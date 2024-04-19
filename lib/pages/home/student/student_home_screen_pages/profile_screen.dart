import 'package:final_project/controllers/profile_controller.dart';
import 'package:final_project/pages/common/books/books_modal.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/edit_student_profile.dart';
import 'package:final_project/pages/home/student/cards/lecture_details.dart';
import 'package:final_project/pages/home/student/cards/saved_books_card.dart';
import 'package:final_project/pages/home/student/cards/saved_lecture_card.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/explore_schemes.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/student_stats.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/enrolled_courses.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/books_provider.dart';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/providers/books_provider.dart';
import 'package:final_project/style/painter.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:googleapis/appengine/v1.dart';
import 'package:logger/web.dart';

import '../../../../models/backend_model.dart';
import '../../../common/start_screen.dart';

class StudentProfileScreen extends ConsumerStatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  ConsumerState<StudentProfileScreen> createState() => _ProfileScreenState();
}

final graphProvider = StateProvider((ref) => false);

class _ProfileScreenState extends ConsumerState<StudentProfileScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final appBarNotifier = ref.watch(settingsProvider.notifier);
    final theme = ref.watch(settingsProvider);
    final appBarState = ref.watch(settingsProvider);
    var graph = ref.watch(graphProvider.notifier);
    final profileController = Get.put(ProfileController());
    return FutureBuilder(
        future: profileController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the future is loading, show a loading indicator
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If an error occurs while loading the future, show an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // Once the future completes, access the Student object from the snapshot
            Student student = snapshot.data as Student;

            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                forceMaterialTransparency: true,
                toolbarHeight: 80,
                backgroundColor: Theme.of(context).primaryColor,
                title: GeneralAppText(
                  text: 'My Profile',
                  size: 23,
                  weight: FontWeight.bold,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: GeneralAppIcon(
                      icon: Icons.poll_outlined,
                      color: theme.isLightMode == true ? textColor1 : textColor2,
                    ),
                    onPressed: () {
                      setState(() {
                        graph.state = !graph.state;
                      });
                    },
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        icon: GeneralAppIcon(
                          icon: Icons.settings,
                          color: theme.isLightMode == true ? textColor1 : textColor2,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                      );
                    },
                  ),
                ],
              ),
              endDrawer: Drawer(
                backgroundColor: Theme.of(context).primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.6,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                foregroundColor: Colors.white,
                                radius: 35,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.white,
                                    foregroundImage: MemoryImage(student.thumbnailImage),
                                  ),
                                ),
                              ),
                            ),
                            // username from firebase
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: GeneralAppText(
                                text: student.username,
                                size: 20,
                                weight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListBody(
                        children: [
                          ListTile(
                            leading: GeneralAppIcon(
                              icon: appBarState.isLightMode
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                              color:
                              theme.isLightMode == true ? textColor1 : textColor2,
                              size: 20,
                            ),
                            title: GeneralAppText(
                              text: 'Change Theme',
                              size: 16,
                              weight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              appBarNotifier.isLightMode = !appBarNotifier.isLightMode;
                              appBarNotifier.savePreferences();
                            },
                          ),
                          ListTile(
                            leading: GeneralAppIcon(
                              icon: Icons.language,
                              color:
                              theme.isLightMode == true ? textColor1 : textColor2,
                              size: 20,
                            ),
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(10),
                                menuMaxHeight: 400,
                                onChanged: (String? value) {
                                  setState(() {
                                    appBarNotifier.selectedLang = value!;
                                    appBarNotifier.savePreferences();
                                  });
                                },
                                value: appBarState.selectedLang,
                                items: langs.keys.map<DropdownMenuItem<String>>(
                                      (e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: DropdownText(
                                        text: e,
                                        size: 16,
                                        weight: FontWeight.bold,
                                        color: theme.isLightMode == true
                                            ? textColor1
                                            : textColor2,
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: GeneralAppIcon(
                              icon: Icons.person,
                              color:
                              theme.isLightMode == true ? textColor1 : textColor2,
                              size: 20,
                            ),
                            title: GeneralAppText(
                              text: 'Edit Profile',
                              size: 16,
                              weight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  context: context,
                                  builder: (builder) {
                                    return const EditStudentProfile();
                                  });
                            },
                          ),
                          ListTile(
                            leading: GeneralAppIcon(
                              icon: Icons.logout,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            title: PrimaryAppText(
                              text: 'Log Out',
                              size: 16,
                              weight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                            onTap: () {
                              AuthenticationRepository.instance.signOut();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return StartScreen();
                                  }));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 20,
                              ),
                              height: 100,
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: MemoryImage(student.thumbnailImage),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SecondaryAppText(
                                  text: student.firstName + " "+ student.lastName,
                                  size: 22,
                                  color: theme.isLightMode == true
                                      ? textColor1
                                      : textColor2,
                                  weight: FontWeight.bold,
                                ),
                                SecondaryAppText(
                                  text: student.username,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const StudentStats()
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}
