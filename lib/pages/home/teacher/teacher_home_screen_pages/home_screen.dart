import 'package:final_project/pages/common/chat/chat_list.dart';
import 'package:final_project/pages/common/gemini.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_course.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_lecture.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_visit.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherHomeScreen extends ConsumerStatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  ConsumerState<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends ConsumerState<TeacherHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.read(settingsProvider.notifier).isLightMode;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          color: Theme.of(context).primaryColor,
          // padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
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
                child: GeneralAppText(
                  text: "jainambarbhaya",
                  size: 20,
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
                                // width: MediaQuery.sizeOf(context).width,
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
                                  ],
                                ),
                              );
                            });
                      },
                      child: GeneralAppIcon(
                        color: theme == true ? textColor1 : textColor2,
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
                      Navigator.push(
                          context, _createScreenRoute(const ChatScreen()));
                      // Navigator.pushNamed(context, 'chatScreen');
                    },
                    child: GeneralAppIcon(
                      icon: Icons.chat_bubble_outline,
                      color: theme == true ? textColor1 : textColor2,
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
      body: Container(
        child: Center(
          child: Text('Teacher Home Screen'),
        ),
      ),
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

  Route _createUploadRouteAnimation(
      Widget child) {
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
