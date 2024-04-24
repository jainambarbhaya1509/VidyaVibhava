import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/controllers/profile_controller.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/pages/common/chat/chat_list.dart';
import 'package:final_project/pages/common/chat/chintan_chat_page_2.dart';
import 'package:final_project/pages/common/gemini.dart';
import 'package:final_project/pages/home/student/cards/assignment_details.dart';
import 'package:final_project/pages/home/student/cards/assignment_details.dart';
import 'package:final_project/pages/home/student/cards/course_details.dart';
import 'package:final_project/pages/home/student/cards/lecture_details.dart';
import 'package:final_project/pages/home/student/cards/saved_videos_card.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/all_assignments.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/jobs_screen.dart';
import 'package:final_project/pages/home/teacher/cards/assignment_status.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/check_assignments.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_course.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/lecture_data_provider.dart';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:googleapis/keep/v1.dart';
import 'package:intl/intl.dart';
import 'package:logger/web.dart';

import '../../../../models/backend_model.dart';

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

final assignmentProvider = Provider((ref) => assignments);
final assignments = [
  {
    "title": "English Essay",
    "description": "Write an essay on the theme of nature in literature.",
    "dueDate": "12/12/2021",
    "marks": "10",
    "documents": [],
  },
  {
    "title": "Math Homework",
    "description": "Solve the practice problems from Chapter 3.",
    "dueDate": "12/12/2021",
    "marks": "10",
    "documents": [],
  },
  {
    "title": "Science Project",
    "description": "Prepare a presentation on the solar system.",
    "dueDate": "12/12/2021",
    "marks": "10",
    "documents": [],
  },
  {
    "title": "History Assignment",
    "description":
        "Research and write about a historical event of your choice.",
    "dueDate": "12/12/2021",
    "marks": "10",
    "documents": [],
  },
  {
    "title": "Art Project",
    "description": "Create a painting inspired by a famous artist.",
    "dueDate": "12/12/2021",
    "marks": "10",
    "documents": [],
  },
  {
    "title": "Music Composition",
    "description": "Compose a short piece of music using any instrument.",
    "dueDate": "12/12/2021",
    "marks": "10",
    "documents": [],
  }
];

class StudentHomeScreen extends ConsumerStatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  ConsumerState<StudentHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final theme = ref.read(settingsProvider.notifier).isLightMode;
    // return FutureBuilder(
    //   future: controller.getUserData(),
    //   builder: (context, snapshot) {
    //     late Student student;
    //     try {
    //       if (snapshot.data != null) {
    //         student = snapshot.data as Student;
    //       }
    //     } on Exception catch (e) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasData) {
    //         final lectureData = ref.read(lectureDataProvider);
    //         final assignment = ref.read(assignmentProvider);
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
                // text: "Hi, ${student.firstName}",
                text: "Hi, Chintan",
                size: 20,
                weight: FontWeight.bold,
                color: theme == true ? textColor1 : textColor2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                      /*Navigator.push(context,
                                  _createAnimatedScreenRoute(const ChatScreen(), 1, 0));*/
                      Navigator.push(
                          context,
                          _createAnimatedScreenRoute(
                              const ChatActivity(), 1, 0));
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
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (builder) {
                                return Container(
                                  color: Theme.of(context).primaryColor,
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 30, top: 40),
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.20,
                                            decoration: BoxDecoration(
                                              color:
                                                  primaryColor.withOpacity(0.8),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                PrimaryAppText(
                                                  text: subjects[index].name,
                                                  size: 25,
                                                  weight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: GeneralAppIcon(
                                                    icon: Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            ),
                                            child: Material(
                                              elevation: 5,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 60,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                    hintText:
                                                        "Search for ${subjects[index].name}",
                                                    prefixIcon: GeneralAppIcon(
                                                      icon: Icons.search,
                                                      color: Colors.grey,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GeneralAppText(
                                                  text: "Results",
                                                  size: 20,
                                                  weight: FontWeight.bold,
                                                ),
                                                const SubjectFilterDropdown(),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SingleChildScrollView(
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.65,
                                                child: GridView.builder(
                                                  itemCount: 10,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio: 1.5,
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 10),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          isDismissible: true,
                                                          context: context,
                                                          builder: (builder) {
                                                            // return LectureDetails();
                                                            return Container();
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: theme == true
                                                              ? textColor1
                                                              : textColor2,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
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
                  Expanded(
                    child: GeneralAppText(
                      text: "Explore Courses ",
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
                            return CourseDetails(
                                courseIndex: index,
                                courseTitle: "Course Title $index",
                                courseDescription:
                                    "The labyrinthine complexity of human existence intertwines with the capricious whims of fate, weaving a tapestry of stories where the mundane and the extraordinary collide, where love and loss dance a perpetual waltz amidst the cacophony of existence, each individual thread contributing to the rich fabric of the universe's eternal narrative.",
                                courseLectures: [
                                  "Course Lecture $index",
                                  "Course Lecture $index"
                                ]);
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
                            return Container(); //LectureDetails();
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
              FutureBuilder<List<Video>>(
                future: controller.getVideoData(),
                builder: (context, snapshot) {
                  late List<Video> videoList;
                  try {
                    if (snapshot.data != null) {
                      videoList = snapshot.data as List<Video>;
                    } else {
                      print("Snapshot.data is null");
                    }
                  } on Exception catch (e) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 100,
                        // color: Colors.amber,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: videoList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print(
                                    "Video Tapped---------------------------------------------------------------------");
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return LectureDetails(
                                        video: videoList[
                                            index]); // Provide the Video object here
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
                                child: Image.memory(
                                  videoList[index]
                                      .thumbnailImage, // Convert data to Uint8List
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const AllAssignments()));
                    },
                    child: GeneralAppIcon(
                      icon: Icons.navigate_next_sharp,
                      color: primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              FutureBuilder(
                future: controller.getAssignmentData(),
                builder: (context, snapshot) {
                  late List<Assignment>? assignmentList;
                  late Assignment? assignment;
                  try {
                    if (snapshot.data != null) {
                      assignmentList = snapshot.data as List<Assignment>?;
                    }
                  } on Exception catch (e) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 260,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: theme.isLightMode ? textColor1 : textColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: theme ? textColor2 : textColor1,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (builder) {
                                      assignment = assignmentList?[index];
                                      return AssignmentDetails(
                                        index: index,
                                        title: assignment!.title,
                                        description: assignment!.question,
                                        dueDate: DateFormat(
                                                'yyyy-MM-dd HH:mm:ss')
                                            .format(
                                                (assignment!.dueDate).toDate()),
                                        marks: assignment!.totalMarks,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: theme
                                        ? const Color.fromARGB(
                                            211, 228, 228, 228)
                                        : const Color.fromARGB(255, 54, 54, 54),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GeneralAppText(
                                          text: assignment!.title, size: 16),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GeneralAppText(
                                          text: assignment!.question, size: 16),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: GeneralAppText(
                                                text:
                                                    "Marks: ${assignment!.totalMarks}",
                                                size: 16,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          GeneralAppText(
                                            text: DateFormat(
                                                    'yyyy-MM-dd HH:mm:ss')
                                                .format((assignment!.dueDate)
                                                    .toDate()),
                                            size: 16,
                                            weight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text("Something went wrong"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
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
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text(snapshot.error.toString()));
    //       } else {
    //         return const Center(child: Text("Something went wrong"));
    //       }
    //     } else {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
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

List filterType = ["Videos", "Courses"];

class SubjectFilterDropdown extends StatefulWidget {
  const SubjectFilterDropdown({super.key});

  @override
  State<SubjectFilterDropdown> createState() => _SubjectFilterDropdownState();
}

class _SubjectFilterDropdownState extends State<SubjectFilterDropdown> {
  String selectedFilter = filterType.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      value: selectedFilter,
      items: filterType
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (String? value) {
        setState(() {
          selectedFilter = value!;
        });
      },
    );
  }
}
