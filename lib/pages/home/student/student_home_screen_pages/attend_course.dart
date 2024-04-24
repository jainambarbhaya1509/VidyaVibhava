import 'package:final_project/pages/home/student/controller/lecture_controller.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/lecture_data_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/keep/v1.dart';
import 'package:logger/web.dart';

class AttendCourse extends ConsumerStatefulWidget {
  final int courseIndex;
  const AttendCourse({
    super.key,
    required this.courseIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttendCourseState();
}

class _AttendCourseState extends ConsumerState<AttendCourse> {
  // final nextContent;

  @override
  Widget build(BuildContext context) {
    bool isQuiz = true;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: "Attend Course",
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: isQuiz ? BuildQuiz() : BuildVideo(),
        ),
      ),
    );
  }
}

class BuildQuiz extends ConsumerStatefulWidget {
  const BuildQuiz({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuildQuizState();
}

class _BuildQuizState extends ConsumerState<BuildQuiz> {
  @override
  Widget build(BuildContext context) {
    String? selectedOption;
    final theme = ref.watch(settingsProvider.notifier);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 100),
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.isLightMode
                ? const Color.fromARGB(211, 228, 228, 228)
                : const Color.fromARGB(255, 54, 54, 54),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GeneralAppText(
                    text: "Question 1",
                    size: 17,
                    weight: FontWeight.bold,
                  ),
                  GeneralAppText(
                    text: "What is the capital of Nigeria?",
                    size: 16,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: "A",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                });
                              },
                            ),
                            Expanded(
                              child: SecondaryAppText(
                                text:
                                    "hello my name is jainam barbhaya i am a software engineer",
                                size: 15,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: "B",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                });
                              },
                            ),
                            Expanded(
                              child: SecondaryAppText(
                                text: "a",
                                size: 15,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: "C",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                });
                              },
                            ),
                            Expanded(
                              child: SecondaryAppText(
                                text: "D",
                                size: 15,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: "Q",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                });
                              },
                            ),
                            Expanded(
                              child: SecondaryAppText(
                                text: "a",
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: PrimaryAppText(
                  text: "Submit",
                  size: 20,
                  weight: FontWeight.bold,
                  color: primaryColor,
                ),
              )
            ],
          ),
        ),
        Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryAppText(
                  text: "Congratulations!",
                  size: 20,
                  weight: FontWeight.bold,
                  color: Colors.green,
                ),
                GeneralAppText(
                  text: "Your answer is correct",
                  size: 15,
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryAppText(
                  text: "Next",
                  size: 20,
                  weight: FontWeight.bold,
                  color: primaryColor,
                )
              ],
            ))
      ],
    );
  }
}

class BuildVideo extends ConsumerStatefulWidget {
  const BuildVideo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuildVideoState();
}

class _BuildVideoState extends ConsumerState<BuildVideo> {
  @override
  Widget build(BuildContext context) {
    final lectureVideo = ref.read(lectureDataProvider);
    final theme = ref.watch(settingsProvider.notifier);
    CourseData course = CourseData();
    int playNext = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   height: 200,
        //   alignment: Alignment.center,
        //   width: double.infinity,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           GeneralAppIcon(
        //             icon: Icons.replay_10,
        //             color: Colors.grey[100] ?? Colors.grey,
        //             size: 40,
        //           ),
        //           GeneralAppIcon(
        //             icon: Icons.play_arrow,
        //             color: Colors.grey[100] ?? Colors.grey,
        //             size: 40,
        //           ),
        //           GeneralAppIcon(
        //             icon: Icons.forward_10_outlined,
        //             color: Colors.grey[100] ?? Colors.grey,
        //             size: 40,
        //           ),
        //         ],
        //       ),
        //       // Row(
        //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       //   crossAxisAlignment: CrossAxisAlignment.center,
        //       //   children: [
        //       //     GeneralAppIcon(
        //       //       icon: Icons.replay_10,
        //       //       color: Colors.grey[100] ?? Colors.grey,
        //       //       size: 25,
        //       //     ),
        //       //     GeneralAppIcon(
        //       //       icon: Icons.play_arrow,
        //       //       color: Colors.grey[100] ?? Colors.grey,
        //       //       size: 25,
        //       //     ),
        //       //   ],
        //       // ),
        //     ],
        //   ),
        // ),

        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GeneralAppText(
                    text: "Course Title ${lectureVideo.course[0].courseTitle}",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        playNext++;
                        final courseItem = course.course[playNext - 1];

                        if (courseItem is Lecture) {
                          setState(() {
                            // nextContent = courseItem;
                          });
                        } else if (courseItem is Quiz) {
                          Logger().e(courseItem);
                        } else {
                          playNext = 0;
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: PrimaryAppText(
                            text: "Next",
                            size: 20,
                            weight: FontWeight.bold,
                            color: primaryColor,
                          )))
                ],
              ),
              GeneralAppText(
                text: "William Shakespeare",
                size: 15,
                weight: FontWeight.w400,
              ),
              const SizedBox(
                height: 20,
              ),
              GeneralAppText(
                text: "Duration",
                size: 18,
                weight: FontWeight.bold,
              ),
              GeneralAppText(
                text: "1 Hour",
                size: 14,
                weight: FontWeight.w400,
              ),
              const SizedBox(
                height: 20,
              ),
              GeneralAppText(
                text: "Description",
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 5,
              ),
              GeneralAppText(
                text:
                    "The Merchant of Venice is a 16th-century play written by William Shakespeare in which a merchant in Venice named Antonio defaults on a large loan provided by a Jewish moneylender, Shylock. It is believed to have been written between 1596 and 1599.",
                size: 14,
                weight: FontWeight.w400,
              ),
              const SizedBox(
                height: 20,
              ),
              // GeneralAppText(
              //   text: "Lectures",
              //   size: 18,
              //   weight: FontWeight.bold,
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Container(
              //   height: 400,
              //   width: double.infinity,
              //   child: ListView.builder(
              //     itemCount: 100,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         margin: const EdgeInsets.only(bottom: 10),
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 10, vertical: 10),
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.grey),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             GeneralAppText(
              //               text: "Lecture ${index + 1}",
              //               size: 16,
              //               weight: FontWeight.bold,
              //             ),
              //             GeneralAppText(
              //               text: "1 Hour",
              //               size: 14,
              //               weight: FontWeight.w400,
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Container(
                alignment: Alignment.centerRight,
                child: PrimaryAppText(
                  text: "Next Video: Lecture 1",
                  size: 15,
                  weight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: theme.isLightMode
                          ? const Color.fromARGB(211, 228, 228, 228)
                          : const Color.fromARGB(255, 54, 54, 54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 400,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GeneralAppText(
                                  text: "Mr. John Doe",
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                                GeneralAppText(
                                  text: "Instructional Designer",
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        // other lectures by
                        GeneralAppText(
                          text: "Other Lectures by Mr. John Doe",
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          ),
                        ),
                        // upcoming visits
                        const SizedBox(
                          height: 20,
                        ),
                        GeneralAppText(
                          text: "Upcoming Visits",
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
