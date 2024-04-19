import 'package:final_project/pages/home/student/student_home_screen_pages/web_view_page.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/services/api_service.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';

class ExploreSchemes extends ConsumerStatefulWidget {
  const ExploreSchemes({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExploreSchemesState();
}

class _ExploreSchemesState extends ConsumerState<ExploreSchemes> {
  TextEditingController searchQuery = TextEditingController();
  List categories = ["All", "Scholarship", "Internship", "Job"];
  String selectedCategory = "All";
  List<dynamic> results = [];
  APIService apiService = APIService();
  Future<void> fetchScholarshipInfo(String query) async {
    print("Selected Category : ${selectedCategory}");
    List<dynamic> fetchedResults = await apiService.fetchScholarshipInfo(query, selectedCategory);
    //setState(() { results = fetchedResults;});

    /*List<dynamic> fetchedResults = [
      {"title": "Scholarship 1", "description": "Description 1", "link":"bwdjwdjw"},
      {"title": "Scholarship 2", "description": "Description 2", "link":"hvxjgwdguw"}
    ];*/

    // Update state with fetched results
    setState(() {
      results = fetchedResults;
      print(results);
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppText(
              text: "Explore Schemes",
              size: 20,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.isLightMode
                    ? const Color.fromARGB(211, 228, 228, 228)
                    : const Color.fromARGB(255, 54, 54, 54),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(onTap:(){fetchScholarshipInfo(searchQuery.text);},child: Icon(Icons.search, color: Colors.grey)),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: searchQuery,
                      onFieldSubmitted: (value) {
                        fetchScholarshipInfo(value); // Call fetch function on submit
                      },
                      decoration: const InputDecoration(
                        hintText: "Search with a keyword",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                GeneralAppText(
                  text: "Results",
                  size: 19,
                  weight: FontWeight.bold,
                ),
                const Spacer(),
                DropdownButton(
                  value: selectedCategory,
                  items: categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text("$category"),
                        ),
                      )
                      .toList(),
                  onChanged: (Object? category) {
                    Logger().i(category);
                    setState(() {
                      selectedCategory = category?.toString() ?? "All";
                    });
                  },
                )
              ],
            ),
            
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  Map<String, String> result = Map<String, String>.from(results[index]);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: theme.isLightMode
                          ? const Color.fromARGB(211, 228, 228, 228)
                          : const Color.fromARGB(255, 54, 54, 54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralAppText(
                          text: result["title"]!,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(height: 10),
                        GeneralAppText(
                          text:result["description"]!,
                          size: 16,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewPage(result["link"]!),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              PrimaryAppText(
                                color: primaryColor,
                                text: "Read More",
                                size: 16,
                                weight: FontWeight.bold,
                              ),
                              const SizedBox(width: 10),
                              GeneralAppIcon(
                                  icon: Icons.arrow_right_alt_sharp,
                                  color: primaryColor)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
