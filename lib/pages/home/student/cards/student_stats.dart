import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentStats extends ConsumerStatefulWidget {
  const StudentStats({super.key});

  @override
  ConsumerState<StudentStats> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends ConsumerState<StudentStats> {
  List<Color> gradientColors = [Colors.green, Colors.blue];

  bool showAvg = false;

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
    ref.watch(settingsProvider);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GeneralAppText(
                text: "Your Statistics",
                weight: FontWeight.bold,
                size: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: videosPerSubject.keys.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GeneralAppText(
                                  text: videosPerSubject.keys.elementAt(index),
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
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
