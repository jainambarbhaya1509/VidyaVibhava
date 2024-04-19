import 'package:final_project/controllers/profile_controller.dart';
import 'package:final_project/controllers/video_controller.dart';
import 'package:final_project/pages/home/student/cards/course_details.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../models/backend_model.dart';

class EnrolledCourses extends ConsumerStatefulWidget {
  const EnrolledCourses({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnrolledCoursesState();
}

class _EnrolledCoursesState extends ConsumerState<EnrolledCourses> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier).isLightMode;
    final controller = Get.put(ProfileController());
    List<EnrolledCourse> courseList = [];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GeneralAppText(
                text: "Enrolled Courses",
                size: 23,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: controller.getEnrolledCourseDataList(),
                builder: (context, snapshot) {
                  try {
                    if (snapshot.data != null) {
                      courseList = snapshot.data as List<EnrolledCourse>;
                    }
                  } on Exception catch (e) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: courseList.length,
                        itemBuilder: (context, index) {
                          EnrolledCourse enrolledCourse = courseList[index];
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: true,
                                context: context,
                                builder: (builder) {
                                  return CourseDetails(
                                      courseId:enrolledCourse.courseId);
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber
                                      // image: const DecorationImage(
                                      //   image: NetworkImage(''),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: GeneralAppText(
                                          text: "The brief history of modern india",
                                          size: 16,
                                          weight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text("Something went wrong"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
