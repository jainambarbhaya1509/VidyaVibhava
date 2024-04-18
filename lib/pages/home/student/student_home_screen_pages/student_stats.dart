import 'package:final_project/pages/home/student/student_home_screen_pages/profile_screen.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StudentStats extends ConsumerStatefulWidget {
  const StudentStats({super.key});

  @override
  ConsumerState<StudentStats> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends ConsumerState<StudentStats> {
  final videosPerSubject = {
    "Language": 10,
    "Mathematics": 10,
    "Physics": 20,
    "Chemistry": 30,
    "Biology": 40,
    "English": 50,
    "History": 60,
    "Geography": 70,
  };

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    final graph = ref.watch(graphProvider);
    return graph
        ? Container(
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.isLightMode
                          ? const Color.fromARGB(255, 231, 231, 231)
                          : const Color.fromARGB(255, 64, 64, 64),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GeneralAppText(
                                  text: "Total Videos",
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                                GeneralAppText(
                                  text: "10",
                                  size: 16,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                GeneralAppText(
                                  text: "Total Courses",
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                                GeneralAppText(
                                  text: "10",
                                  size: 16,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.isLightMode
                          ? const Color.fromARGB(255, 231, 231, 231)
                          : const Color.fromARGB(255, 64, 64, 64),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GeneralAppText(
                                  text: "Courses Enrolled",
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                                GeneralAppText(
                                  text: "10",
                                  size: 16,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                GeneralAppText(
                                  text: "Courses Completed",
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                                GeneralAppText(
                                  text: "10",
                                  size: 16,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: theme.isLightMode
                          ? const Color.fromARGB(255, 231, 231, 231)
                          : const Color.fromARGB(255, 64, 64, 64),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                      ),
                      itemCount: videosPerSubject.keys.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GeneralAppText(
                                    text:
                                        videosPerSubject.keys.elementAt(index),
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  GeneralAppText(
                                    text: videosPerSubject.values
                                        .elementAt(index)
                                        .toString(),
                                    size: 16,
                                    weight: FontWeight.bold,
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: theme.isLightMode
                          ? const Color.fromARGB(255, 231, 231, 231)
                          : const Color.fromARGB(255, 64, 64, 64),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GeneralAppText(
                                      text: "Overall Progress",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    GeneralAppText(
                                      text: "90%",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 100,
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            width: double.infinity,
            child: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.disabled)
                ..loadHtmlString(
                  '<html><body><h1>Explore Schemes</h1><p>Click the button below to explore the schemes</p><button onclick="window.location.href=\'https://www.google.com\'">Explore</button></body></html>',
                ),
            ),
          );
  }
}
