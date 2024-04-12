import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/models/backend_model.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';

import '../../../../controllers/profile_controller.dart';
import '../../../../controllers/video_controller.dart';

class CreateCourse extends ConsumerStatefulWidget {
  const CreateCourse({super.key});

  @override
  ConsumerState<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends ConsumerState<CreateCourse> {
  final lectureTitleController = TextEditingController();
  final lectureDescriptionController = TextEditingController();
  final lectureDurationController = TextEditingController();
  final subjectController = TextEditingController();
  final lectureLevel = ["Beginner", "Intermediate", "Advanced"];
  String? selectedLevel;

  List<VideoPlayerController>? controllers = [];

  final List uploadedVideos = [];

  final createQuiz = [
    {
      "question": "",
      "options": [],
      "correctAnswer": "",
    },
  ];

  Future<void> uploadCourse() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mkv', 'mov'],
    );

    if (result == null || result.files.isEmpty) return;

    setState(() {
      uploadedVideos.addAll(result.files);
      controllers?.addAll(result.files.map((file) {
        return VideoPlayerController.file(File(file.path!))
          ..initialize().then((_) {
            setState(() {});
          });
      }).toList());
    });
  }

  bool checkAllFields() {
    if (lectureTitleController.text.isEmpty ||
        lectureDescriptionController.text.isEmpty ||
        lectureDurationController.text.isEmpty ||
        uploadedVideos.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier).isLightMode;

    final profileController = Get.put(ProfileController());
    final videoController = Get.put(VideoController());
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: 'Create Course',
          color: Colors.white,
          size: 20,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(25),
            child: Column(
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: theme
                          ? Colors.white70
                          : const Color.fromARGB(255, 62, 62, 62),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: GeneralAppText(
                              text: "Upload course videos",
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => uploadCourse(),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FittedBox(
                                child: PrimaryAppText(
                                  text: "Upload Videos",
                                  size: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Uploaded Videos",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: uploadedVideos.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: GeneralAppText(
                                      text: "No videos uploaded",
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: uploadedVideos.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10, left: 10),
                                            height: 50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GeneralAppText(
                                                  text: "${index + 1}. ",
                                                  size: 14,
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      final controller =
                                                          controllers![index];
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Dialog(
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                      height:
                                                                          200,
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child: controller
                                                                              .value
                                                                              .isInitialized
                                                                          ? VideoPlayer(
                                                                              controller)
                                                                          : Container()),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        if (controller
                                                                            .value
                                                                            .isPlaying) {
                                                                          controller
                                                                              .pause();
                                                                        } else {
                                                                          controller
                                                                              .play();
                                                                        }
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: theme
                                                                            ? textColor1
                                                                            : textColor2,
                                                                        borderRadius:
                                                                            BorderRadius.circular(50),
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        color: theme
                                                                            ? textColor2
                                                                            : textColor1,
                                                                        controller.value.isPlaying
                                                                            ? Icons.pause
                                                                            : Icons.play_arrow,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      height: 60,
                                                      child: GeneralAppText(
                                                        text: uploadedVideos[
                                                                    index]
                                                                ?.name ??
                                                            "",
                                                        size: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GeneralAppIcon(
                                                  icon: Icons.delete,
                                                  size: 20,
                                                  color: Colors.redAccent,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Divider(
                                                thickness: 0.5,
                                                indent: 20,
                                                endIndent: 20,
                                                color: Colors.grey,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // create quiz

                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    isDismissible: true,
                                                    context: context,
                                                    builder: (builder) {
                                                      return Container(
                                                        height: 700,
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 5,
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                GeneralAppText(
                                                                  text:
                                                                      "Question ${index + 1}",
                                                                  size: 18,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                                  child:
                                                                      TextField(
                                                                    onChanged:
                                                                        (value) {},
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      hintText:
                                                                          'Question',
                                                                    ),
                                                                    inputFormatters: [
                                                                      LengthLimitingTextInputFormatter(
                                                                          100),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                GeneralAppText(
                                                                  text:
                                                                      "Options",
                                                                  size: 18,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              160,
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 8.0),
                                                                          child:
                                                                              TextField(
                                                                            onChanged:
                                                                                (value) {},
                                                                            decoration:
                                                                                InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              hintText: 'Option 1',
                                                                            ),
                                                                            inputFormatters: [
                                                                              LengthLimitingTextInputFormatter(100),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                20),
                                                                        Container(
                                                                          width:
                                                                              160,
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 8.0),
                                                                          child:
                                                                              TextField(
                                                                            onChanged:
                                                                                (value) {},
                                                                            decoration:
                                                                                InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              hintText: 'Option 2',
                                                                            ),
                                                                            inputFormatters: [
                                                                              LengthLimitingTextInputFormatter(100),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              160,
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 8.0),
                                                                          child:
                                                                              TextField(
                                                                            onChanged:
                                                                                (value) {},
                                                                            decoration:
                                                                                InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              hintText: 'Option 3',
                                                                            ),
                                                                            inputFormatters: [
                                                                              LengthLimitingTextInputFormatter(100),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                20),
                                                                        Container(
                                                                          width:
                                                                              160,
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 8.0),
                                                                          child:
                                                                              TextField(
                                                                            onChanged:
                                                                                (value) {},
                                                                            decoration:
                                                                                InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              hintText: 'Option 4',
                                                                            ),
                                                                            inputFormatters: [
                                                                              LengthLimitingTextInputFormatter(100),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                GeneralAppText(
                                                                  text:
                                                                      "Correct Answer",
                                                                  size: 18,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                                  child:
                                                                      DropdownButtonFormField<
                                                                          String>(
                                                                    value:
                                                                        "Option 1",
                                                                    onChanged:
                                                                        (String?
                                                                            value) {},
                                                                    items: [
                                                                      "Option 1",
                                                                      "Option 2",
                                                                      "Option 3",
                                                                      "Option 4",
                                                                    ].map<
                                                                        DropdownMenuItem<
                                                                            String>>((String
                                                                        option) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            option,
                                                                        child: Text(
                                                                            option),
                                                                      );
                                                                    }).toList(),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      hintText:
                                                                          "Correct Answer",
                                                                    ),
                                                                  ),
                                                                ),

                                                                // CREATE QUIZ BUTTON
                                                                const SizedBox(
                                                                    height: 20),
                                                                GestureDetector(
                                                                  onTap: () {},
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            border:
                                                                                Border.all(
                                                                              color: primaryColor,
                                                                              width: 1,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                    child:
                                                                        PrimaryAppText(
                                                                      text:
                                                                          "Create Quiz",
                                                                      size: 18,
                                                                      color:
                                                                          primaryColor,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: GeneralAppIcon(
                                                  icon: Icons.add_box_rounded,
                                                  color: theme
                                                      ? Colors.grey
                                                      : Colors.white,
                                                  size: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Subject",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: subjectController,
                              maxLines: 1,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintMaxLines: 1,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Subject',
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Course Name",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: lectureTitleController,
                              onChanged: (value) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Course Title',
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Course Description",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: lectureDescriptionController,
                              maxLines: 5,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintMaxLines: 100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Course Description',
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Add Tags",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: null,
                              maxLines: 1,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintMaxLines: 1,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Tags',
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Course Level",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: DropdownButtonFormField<String>(
                              value: lectureLevel[0],
                              onChanged: (String? value) {
                                selectedLevel = value;
                              },
                              items: lectureLevel.map<DropdownMenuItem<String>>(
                                  (String level) {
                                return DropdownMenuItem<String>(
                                  value: level,
                                  child: Text(level),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: "Level",
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Course Duration",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: lectureDurationController,
                              onChanged: (value) {},
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Course Duration',
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    print(uploadedVideos);
                    if (checkAllFields()) {
                      Course course = Course(
                          courseTitle: lectureTitleController.text,
                          courseDescription: lectureDescriptionController.text,
                          courseLoc: "",
                          keywords: [""],
                          difficultyLevel: selectedLevel!,
                          duration: lectureDurationController.text,
                          subject: subjectController.text,
                          instructorName: await profileController.getUserFullName(),
                          thumbnail: "thumbnail",
                          instructorId: await profileController.getUserId(),);

                      videoController.createCourse(course, uploadedVideos);
                          //courseVideos: courseVideos)
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: GeneralAppText(
                            text: 'Please fill all fields',
                            size: 16,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: checkAllFields() ? Colors.green : Colors.grey,
                          width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GeneralAppIcon(
                          icon: Icons.file_upload_outlined,
                          size: 20,
                          color: checkAllFields() ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        PrimaryAppText(
                          text: 'Upload',
                          size: 16,
                          color: checkAllFields() ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    lectureTitleController.dispose();
    lectureDescriptionController.dispose();
    lectureDurationController.dispose();
    subjectController.dispose();
    controllers?.forEach((controller) {
      controller.dispose();
    });

    super.dispose();
  }
}
