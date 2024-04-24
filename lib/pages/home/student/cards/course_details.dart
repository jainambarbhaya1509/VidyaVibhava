import 'package:final_project/pages/home/student/student_home_screen_pages/attend_course.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/attend_lecture.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/enrolled_courses.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';

// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class CourseDetails extends ConsumerStatefulWidget {
  final int courseIndex;
  final String courseTitle;
  final String courseDescription;
  final List courseLectures;
  const CourseDetails({
    super.key,
    required this.courseIndex,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseLectures,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends ConsumerState<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier).isLightMode;
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.8,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 5,
                width: 120,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      height: 1000,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 190,
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.centerLeft,
                            child: GeneralAppText(
                              text: widget.courseTitle,
                              size: 20,
                              weight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (enrolledCourses
                                              .map((e) => e["courseId"])
                                              .contains(widget.courseIndex) ==
                                          true) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    AttendCourse(
                                                        courseIndex: widget
                                                            .courseIndex)));
                                      } else {
                                        setState(() {
                                          Map<String, dynamic> courseData = {
                                            "courseId": widget.courseIndex,
                                            "courseTitle": widget.courseTitle,
                                            "courseDescription":
                                                widget.courseDescription,
                                            "courseLectures":
                                                widget.courseLectures,
                                          };
                                          enrolledCourses.add(courseData);
                                        });

                                        Logger().e(enrolledCourses);
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: theme
                                                ? textColor1
                                                : textColor2),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GeneralAppIcon(
                                            icon: enrolledCourses
                                                    .map((e) => e["courseId"])
                                                    .contains(
                                                        widget.courseIndex)
                                                ? Icons.check
                                                : Icons.play_arrow_outlined,
                                            color:
                                                theme ? textColor1 : textColor2,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          PrimaryAppText(
                                            text: enrolledCourses
                                                    .map((e) => e["courseId"])
                                                    .contains(
                                                        widget.courseIndex)
                                                ? "Start Learning"
                                                : "Enroll Course",
                                            size: 20,
                                            color: theme == true
                                                ? textColor1
                                                : textColor2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 10),
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: GeneralAppText(
                                      text: "Description",
                                      size: 20,
                                      weight: FontWeight.bold,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                GeneralAppText(
                                  text: widget.courseDescription,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: GeneralAppText(
                                  text: "Lectures",
                                  size: 20,
                                  weight: FontWeight.bold,
                                )),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.courseLectures.length,
                              itemBuilder: (context, lectureIndex) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: GeneralAppText(
                                    text:
                                        "${lectureIndex + 1}.  Lecture $lectureIndex",
                                    size: 17,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
