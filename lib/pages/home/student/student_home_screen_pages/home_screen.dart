import 'package:final_project/models/models.dart';
import 'package:final_project/pages/common/chat/chat_list.dart';
import 'package:final_project/pages/common/gemini.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentHomeScreen extends ConsumerStatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  ConsumerState<StudentHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<StudentHomeScreen> {
  final List<Subject> subjects = [
    Subject(name: "Language", imageUrl: 'assets/img/lang.png'),
    Subject(name: "Maths", imageUrl: 'assets/img/maths.png'),
    Subject(name: "Physics", imageUrl: 'assets/img/phy.png'),
    Subject(name: "Chemistry", imageUrl: 'assets/img/chem.png'),
    Subject(name: "History", imageUrl: 'assets/img/hist.png'),
    Subject(name: "Geography", imageUrl: 'assets/img/geo.png'),
    Subject(name: "Biology", imageUrl: 'assets/img/bio.png'),

    // Add more subjects here if needed
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ref.read(settingsProvider.notifier).isLightMode;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          color: Theme.of(context).primaryColor,
          // padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SecondaryAppText(
                text: "Hi, Jainam",
                size: 20,
                weight: FontWeight.bold,
                color: theme == true ? textColor1 : textColor2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      child: GeneralAppIcon(
                    color: theme == true ? textColor1 : textColor2,
                    icon: Icons.cases_outlined,
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            _createAnimatedScreenRoute(
                                const GeminiChatBot(), 1, 0));
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
                          _createAnimatedScreenRoute(const ChatScreen(), 1, 0));
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          // color: Colors.white,
          padding: const EdgeInsets.only(top: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Latest News
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GeneralAppText(
                    text: "What's Latest?",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  GeneralAppIcon(
                    icon: Icons.navigate_next_sharp,
                    color: primaryColor,
                    size: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
              ),
              const SizedBox(
                height: 30,
              ),

              // Explore subjects
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GeneralAppText(
                      text: "Explore Subjects ",
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                  ),
                  GeneralAppIcon(
                    icon: Icons.navigate_next_sharp,
                    color: primaryColor,
                    size: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.23,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              color: theme == true ? textColor1 : textColor2,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image(
                              fit: BoxFit.scaleDown,
                              image: AssetImage(
                                subjects[index].imageUrl,
                              ),
                            ),
                          ),
                        ),
                        GeneralAppText(
                          text: subjects[index].name,
                          color: primaryColor,
                          size: 13,
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // courses
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GeneralAppText(
                    text: "Explore Courses",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  GeneralAppIcon(
                    icon: Icons.navigate_next_sharp,
                    color: primaryColor,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                // color: Colors.amber,
                child: ListView.builder(
                  
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (builder) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Container(
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
                                    Container(
                                      height: 190,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: GeneralAppIcon(
                                              icon: Icons.bookmark_border,
                                              color: theme == true
                                                  ? textColor1
                                                  : textColor2,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: theme == true
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
                                                    icon: Icons
                                                        .play_arrow_rounded,
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2,
                                                    size: 30,
                                                  ),
                                                  PrimaryAppText(
                                                    text: "Start Learning",
                                                    size: 20,
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10),
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
                                            text:
                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia. Nullam nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia.",
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListView.builder(
                                          controller: ScrollController(),
                                          itemCount: 10,
                                          itemBuilder: (context , lectureIndex) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              height: 60,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: SecondaryAppText(
                                                      text: "$lectureIndex",
                                                      size: 20,
                                                      color: theme == true
                                                          ? textColor1
                                                          : textColor2,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: SecondaryAppText(
                                                      text:
                                                          "Lecture Title $lectureIndex",
                                                      size: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),

              // popular lectures
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GeneralAppText(
                    text: "Popular Lectures",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  GeneralAppIcon(
                    icon: Icons.navigate_next_sharp,
                    color: primaryColor,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                // color: Colors.amber,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (builder) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Container(
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
                                    Container(
                                      height: 190,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: GeneralAppIcon(
                                              icon: Icons.bookmark_border,
                                              color: theme == true
                                                  ? textColor1
                                                  : textColor2,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: theme == true
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
                                                    icon: Icons
                                                        .play_arrow_rounded,
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2,
                                                    size: 30,
                                                  ),
                                                  PrimaryAppText(
                                                    text: "Start Learning",
                                                    size: 20,
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10),
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
                                            text:
                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia. Nullam nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia.",
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),

              // continue learning
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GeneralAppText(
                    text: "Continue Learning",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  GeneralAppIcon(
                    icon: Icons.navigate_next_sharp,
                    color: primaryColor,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                // color: Colors.amber,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (builder) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Container(
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
                                    Container(
                                      height: 190,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: GeneralAppIcon(
                                              icon: Icons.bookmark_border,
                                              color: theme == true
                                                  ? textColor1
                                                  : textColor2,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: theme == true
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
                                                    icon: Icons
                                                        .play_arrow_rounded,
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2,
                                                    size: 30,
                                                  ),
                                                  PrimaryAppText(
                                                    text: "Start Learning",
                                                    size: 20,
                                                    color: theme == true
                                                        ? textColor1
                                                        : textColor2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10),
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
                                            text:
                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia. Nullam nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia.",
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),

              // assignments
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GeneralAppText(
                    text: "Assignments",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  GeneralAppIcon(
                    icon: Icons.navigate_next_sharp,
                    color: primaryColor,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                // color: Colors.amber,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          right: 5,
                        ),
                        // height: 10,
                        width: 180,
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: GeneralAppText(
                                  text: "Assignment $index",
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 50,
              ),

              // career path
              GeneralAppText(
                text: "Your Career Path",
                size: 20,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              GeneralAppText(
                text:
                    "Discover your ideal career path with our quick and comprehensive career counselling quiz!",
                size: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'careerQuiz',
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  // margin: const EdgeInsets.only(bottom: 30),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primaryColor, width: 0.9),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GeneralAppIcon(
                            icon: Icons.workspace_premium_rounded,
                            color: primaryColor.withOpacity(0.8)),
                        const SizedBox(
                          width: 10,
                        ),
                        PrimaryAppText(
                          text: 'Craft Your Career Journey',
                          size: MediaQuery.of(context).size.width * 0.04,
                          weight: FontWeight.bold,
                          color: primaryColor.withOpacity(0.8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Animated route
  Route _createAnimatedScreenRoute(
      Widget child, double startOffset, double endOffset) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(startOffset, endOffset);
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
