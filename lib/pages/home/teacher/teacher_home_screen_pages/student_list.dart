import 'package:final_project/pages/home/student/student_home_screen_pages/profile_screen.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/view_student_profile.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentList extends ConsumerStatefulWidget {
  const StudentList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudentListState();
}

class _StudentListState extends ConsumerState<StudentList> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        forceMaterialTransparency: true,
        title: GeneralAppText(
          text: "Student List",
          size: 20,
          weight: FontWeight.bold,
          color: theme.isLightMode ? textColor1 : textColor2,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 60,
                    width: 10,
                    decoration: BoxDecoration(
                      color: theme.isLightMode
                          ? const Color.fromARGB(255, 230, 230, 230)
                          : const Color.fromARGB(255, 64, 64, 64),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(50),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        SecondaryAppText(
                          text: "jainambarbhaya",
                          size: 16,
                          weight: FontWeight.bold,
                          color: theme.isLightMode ? textColor1 : textColor2,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (builder) {
                                      return ViewStudentProfile();
                                    });
                              },
                              child: GeneralAppIcon(
                                icon: Icons.analytics_outlined,
                                color:
                                    theme.isLightMode ? textColor1 : textColor2,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GeneralAppIcon(
                              icon: Icons.video_camera_front,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
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
