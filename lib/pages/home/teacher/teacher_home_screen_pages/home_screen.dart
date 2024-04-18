import 'package:final_project/pages/common/chat/chat_list.dart';
import 'package:final_project/pages/common/chat/chintan_chat_page_teacher.dart';
import 'package:final_project/pages/common/gemini.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/teacher_stats.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_assignment.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_course.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_lecture.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_visit.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controllers/profile_controller.dart';
import '../../../../controllers/teacher_profile_controller.dart';
import '../../../../models/backend_model.dart';

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

class TeacherHomeScreen extends ConsumerStatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  ConsumerState<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends ConsumerState<TeacherHomeScreen> {
  final List uploadedVideos = [];
  final List uploadedCourses = [];
  final List scheduledVisits = [];
  final List assignments = [];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherProfileController());
    final theme = ref.read(settingsProvider);
    return FutureBuilder(
      future: controller.getUserData(),
      builder: (context, snapshot) {
        late Teacher teacher;
        try {
          if (snapshot.data != null) {
            teacher = snapshot.data as Teacher;
          }
        } on Exception catch (e) {
          print("Exception encountered");
          print(e.toString());
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: SecondaryAppText(
                          text: "Hi, ${teacher.firstName}",
                          //text: "Hi, Jainam",
                          size: 20,
                          color: theme.isLightMode ? textColor1 : textColor2,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, top: 10),
                                        height: MediaQuery.sizeOf(context).height * 0.4,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 2,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            FittedBox(
                                              child: GeneralAppText(
                                                text: "Select a field to procees",
                                                size: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      _createUploadRouteAnimation(
                                                          const CreateCourse()),
                                                    );
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                    ),
                                                    child: PrimaryAppText(
                                                      text: "Add Course",
                                                      size: 16,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      _createUploadRouteAnimation(
                                                          const CreateLecture()),
                                                    );
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                    ),
                                                    child: PrimaryAppText(
                                                      text: "Add Lecture",
                                                      size: 16,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(left: 10),
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                    ),
                                                    child: PrimaryAppText(
                                                      text: "Go Live",
                                                      size: 16,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      _createUploadRouteAnimation(
                                                          const CreateVisit()),
                                                    );
                                                  },
                                                  child: Container(
                                                    // margin: EdgeInsets.only(left: 10),
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                    ),
                                                    child: PrimaryAppText(
                                                      text: "Schedule Visit",
                                                      size: 16,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (builder) {
                                                    return const CreateAssignment();
                                                  },
                                                );
                                              },
                                              child: Container(
                                                // margin: EdgeInsets.only(left: 10),
                                                alignment: Alignment.center,
                                                height: 50,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.green,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                child: PrimaryAppText(
                                                  text: "Add Assignment",
                                                  size: 16,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: GeneralAppIcon(
                                color: theme.isLightMode ? textColor1 : textColor2,
                                icon: Icons.add,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context, _createScreenRoute(const GeminiChatBot()));
                              },
                              child: GeneralAppIcon(
                                color: primaryColor,
                                icon: Icons.rocket_launch,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  _createScreenRoute(const TeacherChatActivity()));
                              // Navigator.pushNamed(context, 'chatScreen');
                            },
                            child: GeneralAppIcon(
                              icon: Icons.chat_bubble_outline,
                              color: theme.isLightMode ? textColor1 : textColor2,
                              size: 20,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // teacher stats
                        GeneralAppText(
                          text: "Your Profile Stats",
                          size: 20,
                          color: theme.isLightMode ? textColor1 : textColor2,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.isLightMode
                                ? const Color.fromARGB(211, 228, 228, 228)
                                : const Color.fromARGB(255, 54, 54, 54),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
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
                                child: Container(
                                  alignment: Alignment.center,
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
                        const SizedBox(
                          height: 10,
                        ),
                        // teacher stats per subject
                        Container(
                          decoration: BoxDecoration(
                            color: theme.isLightMode
                                ? const Color.fromARGB(211, 228, 228, 228)
                                : const Color.fromARGB(255, 54, 54, 54),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.3,
                                // crossAxisSpacing: 10
                                mainAxisSpacing: 2),
                            itemCount: videosPerSubject.keys.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin:
                                      const EdgeInsets.only(right: 20, left: 20),
                                      alignment: Alignment.centerLeft,
                                      // color: Colors.amber,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //webview display start
                        //Webviw display end

                // videos uploaded by teacher/mentor
                GeneralAppText(
                  text: "Your Videos",
                  size: 20,
                  color: theme.isLightMode ? textColor1 : textColor2,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                uploadedVideos.isEmpty
                    ? Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: theme.isLightMode ? textColor2 : textColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GeneralAppText(
                              text: "No Videos Found",
                              size: 20,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GeneralAppText(
                              text: "You have not uploaded any videos yet",
                              size: 16,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: theme.isLightMode ? textColor1 : textColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          itemCount: uploadedVideos.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color:
                                    theme.isLightMode ? textColor2 : textColor1,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GeneralAppText(
                                      text:
                                          "${index + 1}. ${uploadedVideos[index]}",
                                      size: 13,
                                      color: theme.isLightMode
                                          ? textColor2
                                          : textColor1,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GeneralAppIcon(
                                    icon: Icons.delete,
                                    color:
                                        const Color.fromARGB(255, 255, 97, 85),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                GeneralAppText(
                  text: "Your Courses",
                  size: 20,
                  color: theme.isLightMode ? textColor1 : textColor2,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                uploadedCourses.isEmpty
                    ? Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: theme.isLightMode ? textColor2 : textColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GeneralAppText(
                              text: "No Courses Found",
                              size: 20,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GeneralAppText(
                              text: "You have not uploaded any courses yet",
                              size: 16,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: theme.isLightMode ? textColor1 : textColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          itemCount: uploadedVideos.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color:
                                    theme.isLightMode ? textColor2 : textColor1,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                        child: GeneralAppText(
                                      text:
                                          "${index + 1}. ${uploadedCourses[index]}",
                                      size: 13,
                                      color: theme == true
                                          ? textColor2
                                          : textColor1,
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GeneralAppIcon(
                                    icon: Icons.delete,
                                    color:
                                        const Color.fromARGB(255, 255, 97, 85),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                // scheduled visit
                GeneralAppText(
                  text: "Scheduled Visits",
                  size: 20,
                  color: theme.isLightMode ? textColor1 : textColor2,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                scheduledVisits.isEmpty
                    ? Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: theme.isLightMode ? textColor2 : textColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GeneralAppText(
                              text: "No Visits Found",
                              size: 20,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GeneralAppText(
                              text: "You have not scheduled any visits yet",
                              size: 16,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: theme.isLightMode ? textColor1 : textColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          itemCount: uploadedVideos.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color:
                                    theme.isLightMode ? textColor2 : textColor1,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GeneralAppText(
                                      text:
                                          "${index + 1}. ${scheduledVisits[index]}",
                                      size: 13,
                                      color: theme.isLightMode
                                          ? textColor2
                                          : textColor1,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GeneralAppIcon(
                                    icon: Icons.delete,
                                    color:
                                        const Color.fromARGB(255, 255, 97, 85),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                // assignments
                // only to display if user is mentor
                const SizedBox(
                  height: 30,
                ),
                GeneralAppText(
                  text: "Assignments",
                  size: 20,
                  color: theme.isLightMode ? textColor1 : textColor2,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),

                        assignments.isEmpty
                            ? Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: theme.isLightMode ? textColor2 : textColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GeneralAppText(
                                text: "No Assignment Found",
                                size: 20,
                                color:
                                theme.isLightMode ? textColor1 : textColor2,
                                weight: FontWeight.bold,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GeneralAppText(
                                text: "You have not assigned any assignments yet",
                                size: 16,
                                color:
                                theme.isLightMode ? textColor1 : textColor2,
                              ),
                            ],
                          ),
                        )
                            : Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: theme.isLightMode ? textColor1 : textColor2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemCount: assignments.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color:
                                  theme.isLightMode ? textColor2 : textColor1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: GeneralAppText(
                                            text:
                                            "${index + 1}. ${assignments[index]}",
                                            size: 13,
                                            color: theme == true
                                                ? textColor2
                                                : textColor1,
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GeneralAppIcon(
                                      icon: Icons.delete,
                                      color:
                                      const Color.fromARGB(255, 255, 97, 85),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: HAHAHAH${snapshot.error.toString()}'));
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Animated route
  Route _createScreenRoute(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Route _createUploadRouteAnimation(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0, 1);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
