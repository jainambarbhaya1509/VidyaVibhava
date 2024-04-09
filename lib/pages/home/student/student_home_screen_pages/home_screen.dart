import 'package:file_picker/file_picker.dart';
import 'package:final_project/controllers/profile_controller.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/pages/common/chat/chat_list.dart';
import 'package:final_project/pages/common/chat/chintan_chat_page_2.dart';
import 'package:final_project/pages/common/gemini.dart';
import 'package:final_project/pages/home/student/cards/course_details.dart';
import 'package:final_project/pages/home/student/cards/lecture_details.dart';
import 'package:final_project/pages/home/student/controller/lecture_controller.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/jobs_screen.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/lecture_data_provider.dart';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:googleapis/keep/v1.dart';

import '../../../../models/backend_model.dart';

const List<String> filterList = <String>["All", "Lecture", "Course"];

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

class StudentHomeScreen extends ConsumerStatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  ConsumerState<StudentHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<StudentHomeScreen> {
  final List uploadedAssignments = [];
  final List assignments = ["Assignment 1", "Assignment 2", "Assignment 3"];

  Future uploadAssignments(String assignmentTitle) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );

    if (result != null) {
      setState(() {
        uploadedAssignments.addAll(result.files.map((file) {
          return {'title': assignmentTitle, 'file': file};
        }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final theme = ref.read(settingsProvider.notifier).isLightMode;
    final lectureData = ref.read(lectureDataProvider);
    // return FutureBuilder(
    //   future: controller.getUserData(),
    //   builder: (context, snapshot) {
    //     late Student student;
    //     try {
    //       student = snapshot.data as Student;
    //     } on Exception catch (e) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasData) {
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
                                const JobsScreen(), 1, 0));
                      },
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
                                  return SingleChildScrollView(
                                    child: Expanded(
                                      child: Container(
                                        color: Theme.of(context).primaryColor,
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30,
                                                            right: 30,
                                                            top: 40),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    width: double.infinity,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.21,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor
                                                          .withOpacity(0.9),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(50),
                                                        bottomRight:
                                                            Radius.circular(50),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        PrimaryAppText(
                                                          text: subjects[index]
                                                              .name,
                                                          size: 25,
                                                          weight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                    ),
                                                    child: Material(
                                                      elevation: 5,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 60,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: TextFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                            hintText:
                                                                "Search for ${subjects[index].name}",
                                                            prefixIcon:
                                                                GeneralAppIcon(
                                                              icon:
                                                                  Icons.search,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 5,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GeneralAppText(
                                                          text: "Results",
                                                          size: 20,
                                                          weight:
                                                              FontWeight.bold,
                                                        ),
                                                        const DropdownFilter()
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.69,
                                                    child: GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              childAspectRatio:
                                                                  1.5,
                                                              crossAxisSpacing:
                                                                  10,
                                                              mainAxisSpacing:
                                                                  10),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10,
                                                                  bottom: 10),
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: theme == true
                                                                ? textColor1
                                                                : textColor2,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        );
                                                      },
                                                      itemCount: 10,
                                                      shrinkWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
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
                          context: context,
                          builder: (builder) {
                            return CourseDetails(
                              courseIndex: index,
                              courseTitle: "Course Title $index",
                              courseDescription:
                                  "The labyrinthine complexity of human existence intertwines with the capricious whims of fate, weaving a tapestry of stories where the mundane and the extraordinary collide, where love and loss dance a perpetual waltz amidst the cacophony of existence, each individual thread contributing to the rich fabric of the universe's eternal narrative.",
                              courseLectures: [
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 90,
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
                  itemCount: LectureData().lectures.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (builder) {
                            // Check Point
                            return LectureDetails(
                                lectureIndex:
                                    lectureData.lectures[index].lectureId,
                                lectureTitle: lectureData.lectures[index].title,
                                lectureDescription:
                                    lectureData.lectures[index].description);
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
                  itemCount: lectureData.lectures.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (builder) {
                            return LectureDetails(
                                lectureIndex:
                                    lectureData.lectures[index].lectureId,
                                lectureTitle: "Lecture Title $index",
                                lectureDescription:
                                    "Lecture Description $index");
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
                    itemCount: assignments.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // String assignmentTitle = assignments[index];
                          // bool isUploaded = uploadedAssignments.any(
                          //     (assignment) =>
                          //         assignment['title'] == assignmentTitle);

                          // showModalBottomSheet(
                          //     context: context,
                          //     builder: (builder) {
                          //       return Container(
                          //         padding: const EdgeInsets.all(15),
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //           color: Theme.of(context).primaryColor,
                          //           borderRadius: const BorderRadius.only(
                          //             topLeft: Radius.circular(10),
                          //             topRight: Radius.circular(10),
                          //           ),
                          //         ),
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.center,
                          //           children: [
                          //             Container(
                          //               alignment: Alignment.center,
                          //               height: 5,
                          //               width: 120,
                          //               decoration: BoxDecoration(
                          //                 color: primaryColor,
                          //                 borderRadius:
                          //                     BorderRadius.circular(20),
                          //               ),
                          //             ),
                          //             const SizedBox(
                          //               height: 30,
                          //             ),
                          //             GeneralAppText(
                          //               text: "Assignment Title $index",
                          //               size: 20,
                          //               weight: FontWeight.bold,
                          //             ),
                          //             const SizedBox(
                          //               height: 10,
                          //             ),
                          //             GeneralAppText(
                          //               text:
                          //                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia. Nullam nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia.",
                          //               size: 15,
                          //             ),
                          //             const SizedBox(
                          //               height: 20,
                          //             ),
                          //             SizedBox(
                          //               height: 60,
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   GeneralAppText(
                          //                     text: "Due Date: 12/12/2021",
                          //                     size: 15,
                          //                   ),
                          //                   Container(
                          //                     margin: const EdgeInsets.only(
                          //                       right: 10,
                          //                     ),
                          //                     child: GeneralAppText(
                          //                       text: "Marks: 10",
                          //                       size: 15,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //             const SizedBox(
                          //               height: 20,
                          //             ),
                          //             GestureDetector(
                          //               onTap: () {
                          //                 uploadAssignments(assignmentTitle);
                          //               },
                          //               child: Container(
                          //                 height: 60,
                          //                 width: double.infinity,
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   borderRadius:
                          //                       BorderRadius.circular(10),
                          //                   border: Border.all(
                          //                       color: isUploaded
                          //                           ? Colors.grey
                          //                           : Colors.green),
                          //                 ),
                          //                 child: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Container(
                          //                       margin: const EdgeInsets.only(
                          //                         left: 10,
                          //                       ),
                          //                       child: PrimaryAppText(
                          //                         text: isUploaded
                          //                             ? "Upload Assignment"
                          //                             : "${assignments.length} Files Uploaded",
                          //                         size: 15,
                          //                         color: isUploaded
                          //                             ? Colors.grey
                          //                             : Colors.green,
                          //                       ),
                          //                     ),
                          //                     Container(
                          //                       margin: const EdgeInsets.only(
                          //                         right: 10,
                          //                       ),
                          //                       child: GeneralAppIcon(
                          //                         icon: isUploaded
                          //                             ? Icons.upload_file
                          //                             : Icons
                          //                                 .check_circle_rounded,
                          //                         color: isUploaded
                          //                             ? Colors.grey
                          //                             : Colors.green,
                          //                         size: 30,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     }).then(
                          //   (value) => setState(
                          //     () {
                          //       uploadedAssignments.removeWhere((element) =>
                          //           element['title'] == assignments[index]);
                          //     },
                          //   ),
                          // );
                        },
                        child: Container(
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

// Dropdown Filter
class DropdownFilter extends StatefulWidget {
  const DropdownFilter({super.key});

  @override
  State<DropdownFilter> createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {
  String filterType = filterList.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: filterType,
      icon: const Icon(
        Icons.arrow_downward_rounded,
        size: 20,
      ),
      onChanged: (String? filter) {
        setState(() {
          filterType = filter!;
        });
      },
      items: filterList.map<DropdownMenuItem<String>>((String filter) {
        return DropdownMenuItem<String>(
          value: filter,
          child: Text(filter),
        );
      }).toList(),
    );
  }
}
