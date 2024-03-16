import 'package:final_project/pages/home/student/cards/books_modal.dart';
import 'package:final_project/pages/home/student/cards/saved_books_card.dart';
import 'package:final_project/pages/signups/signup_pages/personal_info.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:final_project/providers/student_screen_provider.dart';
import 'package:final_project/style/painter.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherProfileScreen extends ConsumerStatefulWidget {
  const TeacherProfileScreen({super.key});

  @override
  ConsumerState<TeacherProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<TeacherProfileScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    final appBarNotifier = ref.watch(settingsProvider.notifier);
    final theme = ref.watch(settingsProvider);
    final appBarState = ref.watch(settingsProvider);

    final savedBooks = ref.watch(savedBooksProvider.notifier).state;
    final imageUrl = savedBooks["imageUrl"];
    final bookTitle = savedBooks["bookTitle"];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                      Navigator.pop(context);
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
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                    ),
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/student2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: GeneralAppText(
                                text: "Jainam Barbhaya",
                                weight: FontWeight.bold,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            FittedBox(
                                child: PrimaryAppText(
                              text: "(Mentor)",
                              color: primaryColor,
                              size: 13,
                            ))
                          ],
                        ),
                        GeneralAppText(
                          text: "jainambarbhaya",
                          size: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 30, right: 20),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GeneralAppText(
                                                text: "Edit Profile",
                                                size: 20,
                                              ),
                                              GeneralAppIcon(
                                                  icon: Icons.close,
                                                  color: theme.isLightMode
                                                      ? textColor1
                                                      : textColor2)
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Material(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  elevation: 5,
                                                  child: SizedBox(
                                                    height: 120,
                                                    width: 120,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image:
                                                              NetworkImage(""),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                PrimaryAppText(
                                                  text: "Change Picture",
                                                  size: 15,
                                                  color: theme.isLightMode
                                                      ? bgColor2
                                                      : bgColor1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: TextField(
                                              controller:
                                                  teacherEmailController,
                                              onChanged: (value) {
                                                ref.read(
                                                        teacherPersonalInfoProvider)[
                                                    'email'] = value;
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                labelText: 'Email Address',
                                              ),
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    100),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextField(
                                            onChanged: (value) {
                                              ref.read(
                                                      teacherPersonalInfoProvider)[
                                                  'phone'] = value;
                                            },
                                            controller: teacherPhoneController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              labelText: 'Phone Number',
                                              prefixIcon: const Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Text(
                                                  '+91 |',
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                            ),
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: PrimaryAppText(
                                                text: "Update",
                                                size: 15,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                child: FittedBox(
                                  child: GeneralAppText(
                                    text: "Edit Profile",
                                    size: 15,
                                    color: Theme.of(context).primaryColor,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          top: 50, left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10, bottom: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              
                                              children: [
                                                GeneralAppText(
                                                  text: "Student List",
                                                  size: 20,
                                                  weight: FontWeight.bold,
                                                  color:
                                                      theme.isLightMode == true
                                                          ? textColor1
                                                          : textColor2,
                                                ),
                                                
                                                GeneralAppIcon(
                                                  icon: Icons.close,
                                                  color: theme.isLightMode
                                                      ? textColor1
                                                      : textColor2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: 3,
                                              itemBuilder: (index, context) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  height: 60,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 62, 62, 62),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 10),
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            color: primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      PrimaryAppText(
                                                        text: "jainambarbhaya",
                                                        size: 16,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                child: FittedBox(
                                  child: GeneralAppText(
                                    text: "Student List",
                                    size: 15,
                                    color: Theme.of(context).primaryColor,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.center,
              child: TabBar(
                labelColor: theme.isLightMode == true ? textColor1 : textColor2,
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
                    text: "Saved Books",
                  ),
                  Tab(
                    text: "Saved Lectures",
                  ),
                ],
              ),
            ),

            // saved books
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.464,
              width: double.maxFinite,
              child: TabBarView(
                controller: tabController,
                children: [
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
                      itemCount: savedBooks["imageUrl"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: true,
                                context: context,
                                builder: (context) {
                                  return BooksModal(
                                    imageUrl: imageUrl[index],
                                    bookTitle: bookTitle[index],
                                  );
                                },
                              );
                            },
                            child: BooksCard(
                              imageUrl: imageUrl[index],
                            ));
                      },
                    ),
                  ),

                  // lectures
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.464,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8 / 0.25,
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              isDismissible: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    index.toString(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            child: Text(
                              index.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


// TODO: Fix Overflow at Name Section