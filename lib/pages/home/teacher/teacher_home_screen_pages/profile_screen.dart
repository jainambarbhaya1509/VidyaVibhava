import 'package:final_project/pages/common/books/books_modal.dart';
import 'package:final_project/pages/home/student/cards/saved_books_card.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/edit_teacher_profile.dart';
import 'package:final_project/pages/signups/signup_pages/personal_info.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:final_project/providers/books_provider.dart';
import 'package:final_project/style/painter.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/authentication_repository.dart';
import '../../../common/start_screen.dart';

class TeacherProfileScreen extends ConsumerStatefulWidget {
  const TeacherProfileScreen({super.key});

  @override
  ConsumerState<TeacherProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<TeacherProfileScreen>
    with TickerProviderStateMixin {
  final List uploadedVideos = [];
  final List uploadedCourses = [];
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    final appBarNotifier = ref.watch(settingsProvider.notifier);
    final theme = ref.watch(settingsProvider);
    final appBarState = ref.watch(settingsProvider);

    final savedBooks = ref.watch(savedBooksProvider);

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
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                padding: const EdgeInsets.only(right: 30),
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

                          // Image from firebase
                          backgroundImage: Image.network(
                            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg',
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ).image,
                        ),
                      ),
                    ),
                    // username from firebase
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: GeneralAppText(
                        text: 'User Name',
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
                      icon: Icons.rocket_outlined,
                      color:
                          theme.isLightMode == true ? textColor1 : textColor2,
                      size: 20,
                    ),
                    title: GeneralAppText(
                      text: 'Chat Bot',
                      size: 16,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                          context: context,
                          builder: (context) {
                            return EditTeacherProfile();
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          // color: Colors.amber,
                          margin: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SecondaryAppText(
                                    text: "Jainam Barbhaya",
                                    weight: FontWeight.bold,
                                    size: 20,
                                    color: theme.isLightMode == true
                                        ? textColor1
                                        : textColor2,
                                  ),
                                  const SizedBox(width: 10),
                                  GeneralAppIcon(
                                    icon: Icons.verified_outlined,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                              SecondaryAppText(
                                text: "jainambarbhaya",
                                size: 15,
                                color: theme.isLightMode == true
                                    ? textColor1
                                    : textColor2,
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.center,
                child: TabBar(
                  labelColor:
                      theme.isLightMode == true ? textColor1 : textColor2,
                  dividerColor: Theme.of(context).primaryColor,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  unselectedLabelColor:
                      theme.isLightMode == true ? textColor1 : textColor2,
                  indicator: const CutomTabIndicator(
                    color: primaryColor,
                    radius: 3,
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: "Your Content",
                    ),
                    Tab(
                      text: "Saved Books",
                    ),
                  ],
                ),
              ),

              // saved books
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.maxFinite,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralAppText(
                              text: "Your Videos",
                              size: 20,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
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
                                      color: theme.isLightMode
                                          ? textColor2
                                          : textColor1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GeneralAppText(
                                          text: "No Videos Found",
                                          size: 20,
                                          color: theme.isLightMode
                                              ? textColor1
                                              : textColor2,
                                          weight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GeneralAppText(
                                          text:
                                              "You have not uploaded any videos yet",
                                          size: 16,
                                          color: theme.isLightMode
                                              ? textColor1
                                              : textColor2,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: theme.isLightMode
                                          ? textColor1
                                          : textColor2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListView.builder(
                                      itemCount: uploadedVideos.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: theme.isLightMode
                                                ? textColor2
                                                : textColor1,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                color: const Color.fromARGB(
                                                    255, 255, 97, 85),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            GeneralAppText(
                              text: "Your Courses",
                              size: 20,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
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
                                      color: theme.isLightMode
                                          ? textColor2
                                          : textColor1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GeneralAppText(
                                          text: "No Courses Found",
                                          size: 20,
                                          color: theme.isLightMode
                                              ? textColor1
                                              : textColor2,
                                          weight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GeneralAppText(
                                          text:
                                              "You have not uploaded any courses yet",
                                          size: 16,
                                          color: theme.isLightMode
                                              ? textColor1
                                              : textColor2,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: theme.isLightMode
                                          ? textColor1
                                          : textColor2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListView.builder(
                                      itemCount: uploadedVideos.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: theme.isLightMode
                                                ? textColor2
                                                : textColor1,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                color: const Color.fromARGB(
                                                    255, 255, 97, 85),
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height * 0.464,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.4 / 0.6,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: savedBooks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: true,
                                context: context,
                                builder: (context) {
                                  return BooksModal(
                                    imageUrl: savedBooks[index]['imageUrl'],
                                    bookTitle: savedBooks[index]['title'],
                                  );
                                },
                              );
                            },
                            child: BooksCard(
                              imageUrl: savedBooks[index]['imageUrl'],
                            ),
                          );
                        },
                      ),
                    ),

                    // lectures
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Fix Overflow at Name Section
