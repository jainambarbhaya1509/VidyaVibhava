import 'package:final_project/models/backend_model.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<List<String>> fetchWhatsLatestDataFromAPI() async {
    final response = await http.get(Uri.parse('http://ec2-65-0-179-201.ap-south-1.compute.amazonaws.com/getUpdates'));
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedResponse = jsonDecode(response.body);
      List<dynamic> responseData = parsedResponse['data'] ?? [];
      List cleanedData = responseData.map((text) => text.replaceAll('\u00a0', '')).toList();
      return cleanedData.map((item) => item.toString()).toList();
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  Future<List<dynamic>> fetchScholarshipInfo(String query, String category) async {
    String apiUrl = "http://ec2-65-0-179-201.ap-south-1.compute.amazonaws.com/getGovtSchemeData";
    try {
      var requestBody = {'filterType': category, 'searchParam':query};
      var jsonBody = jsonEncode(requestBody);
      print('Request body: $jsonBody'); // Log request body
      var response = await http.post(
        Uri.parse(apiUrl.trim()), // Trim apiUrl
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        print('Request successful');
        print('Response body: ${response.body}');
        List<dynamic> parsedResponse = jsonDecode(response.body);
        return parsedResponse;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making POST request: $e');
    }
    return [];
  }


  Future<Career?> getCareerRecommendation(List<int> responses) async {
    Map<int, String> mapping = {0: "No", 1: "Yes"};
    List<String?> responseList = responses.map((item) => mapping[item]).toList();
    String resultString = responseList.join(",");
    print("ResultString : ${resultString}");
    String apiUrl = 'http://ec2-65-0-179-201.ap-south-1.compute.amazonaws.com/getCareerRecommendation';
    try {
      var requestBody = {'list': resultString};
      var jsonBody = jsonEncode(requestBody);
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the content type
        },
        body: jsonBody
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        print('Request successful');
        print('Response body: ${response.body}');
        var responseData = jsonDecode(response.body);

        // Access the value in the "prediction" list
        int prediction = responseData['prediction'][0];
        print('Prediction: $prediction');
        Career career = await UserRepository.instance.getCareerData(prediction);
        return career;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making POST request: $e');
    }
  }
  void sendNotification(){}
  void downloadTextBook(){}
  void getStats(){}
  void getJobs(){}
  void sendOTPtoEmail(){}
}
