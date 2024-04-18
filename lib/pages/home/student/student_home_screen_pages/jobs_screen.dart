import 'dart:convert';

import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/keep/v1.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';

final jobsData = [];

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  Future<List<dynamic>> fetchJobData() async {
    final response = await http.get(Uri.parse(
        'http://ec2-65-0-179-201.ap-south-1.compute.amazonaws.com/search_jobs?query=*&location=India'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      List<dynamic> results = responseData['jobs'];
      Logger().i(results);

      for (var item in results) {
        if (item['company'] != null && //
            item['datePosted'] != null &&
            item['description'] != null &&
            item['employmentType'] != null &&
            item['image'] != null && //
            item['location'] != null &&
            item['salaryRange'] != null &&
            item['title'] != null) {
          Map<String, dynamic> job = {
            'company': item['company'],
            'datePosted': item['datePosted'],
            'description': item['description'],
            'employmentType': item['employmentType'],
            'image': item['image'],
            'location': item['location'],
            'salaryRange': item['salaryRange'],
            'title': item['title'],
          };

          if (mounted) {
            setState(() {
              jobsData.add(job);
            });
          }
        }
      }
    } else {
      throw Exception('Failed to load data');
    }

    return jobsData;
  }

  @override
  void initState() {
    fetchJobData().then((data) {
      if (mounted) {
        jobsData.addAll(data);
        Logger().e(jobsData.length);
        Logger().i(jobsData);
      }
    }).catchError((error) {
      if (!mounted) {
        setState(() {
          jobsData.clear();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: GeneralAppText(
            text: "Search Jobs",
            size: 23,
            weight: FontWeight.bold,
          )),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
          itemCount: jobsData.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: theme.isLightMode
                    ? const Color.fromARGB(211, 228, 228, 228)
                    : const Color.fromARGB(255, 54, 54, 54),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, top: 13),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(jobsData[index]['image']),
                            // scale: 5.0
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 5, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GeneralAppText(
                                  text: jobsData[index]['title'],
                                  size: 17,
                                  weight: FontWeight.bold),
                              GeneralAppText(
                                text: jobsData[index]['company'],
                                size: 14,
                                weight: FontWeight.bold,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              GeneralAppText(
                                text:
                                    "Location: ${jobsData[index]['location']}",
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (builder) {
                            return SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                    top: 35, right: 10, left: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Container()));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        alignment: Alignment.centerRight,
                                        child: PrimaryAppText(
                                          color: primaryColor,
                                          text: "Apply",
                                          size: 20,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  jobsData[index]['image']),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: GeneralAppText(
                                                text: jobsData[index]['title'],
                                                size: 16,
                                                weight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        GeneralAppIcon(
                                            icon: Icons.business_outlined,
                                            color: Colors.grey),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GeneralAppText(
                                          text: jobsData[index]['company'],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        GeneralAppIcon(
                                            icon: Icons.location_on_outlined,
                                            color: Colors.grey),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GeneralAppText(
                                          text: jobsData[index]['location'],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        GeneralAppIcon(
                                            icon:
                                                Icons.monetization_on_outlined,
                                            color: Colors.grey),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GeneralAppText(
                                          text: jobsData[index]
                                                      ['salaryRange'] ==
                                                  ""
                                              ? "Not Specified"
                                              : jobsData[index]['salaryRange'],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        GeneralAppIcon(
                                            icon: Icons.work_outline,
                                            color: Colors.grey),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GeneralAppText(
                                          text: jobsData[index]
                                              ['employmentType'],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        GeneralAppIcon(
                                            icon: Icons.date_range_outlined,
                                            color: Colors.grey),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GeneralAppText(
                                          text: jobsData[index]['datePosted'],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GeneralAppText(
                                            text: "Description",
                                            size: 18,
                                            weight: FontWeight.bold),
                                        GeneralAppText(
                                          text: jobsData[index]['description'],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      alignment: Alignment.center,
                      child: PrimaryAppText(
                        text: "Check Details",
                        size: 15,
                        color: primaryColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
