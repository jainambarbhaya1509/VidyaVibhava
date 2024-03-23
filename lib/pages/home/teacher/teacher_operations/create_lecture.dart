import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class CreateLecture extends ConsumerStatefulWidget {
  const CreateLecture({super.key});

  @override
  ConsumerState<CreateLecture> createState() => _CreateLectureState();
}

class _CreateLectureState extends ConsumerState<CreateLecture> {
  final lectureTitleController = TextEditingController();
  final lectureDescriptionController = TextEditingController();
  final lectureDurationController = TextEditingController();
  final lectureLevel = ["Beginner", "Intermediate", "Advanced"];
  String? selectedLevel;

  VideoPlayerController? controller;
  PlatformFile? lecture;

  Future uploadLecture() async {
    final lecture = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mkv', 'mov'],
    );
    if (lecture == null) return;

    setState(() {
      this.lecture = lecture.files.first;
      controller = VideoPlayerController.file(File(lecture.files.first.path!))
        ..initialize().then((_) {
          setState(() {});
        });
    });
  }

  bool checkAllFields() {
    if (lectureTitleController.text.isEmpty ||
        lectureDescriptionController.text.isEmpty ||
        lectureDurationController.text.isEmpty ||
        lecture == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier).isLightMode;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: 'Create Lecture',
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
                              text: "Upload a video lecture",
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => uploadLecture(),
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
                                  text: "Upload Video",
                                  size: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Preview",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: controller != null
                                      ? VideoPlayer(controller!)
                                      : Container()),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (controller?.value.isPlaying ??
                                        false ||
                                            controller == null ||
                                            controller!.value.isInitialized ||
                                            controller!.value.isBuffering ||
                                            controller!.value.isLooping) {
                                      controller?.pause();
                                    } else {
                                      controller?.play();
                                    }
                                  });
                                },
                                child: Visibility(
                                  visible: controller != null,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: theme ? textColor1 : textColor2,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      color: theme ? textColor2 : textColor1,
                                      controller != null &&
                                              controller!.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Lecture Title",
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
                                labelText: 'Lecture Title',
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Lecture Description",
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
                                labelText: 'Lecture Description',
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
                            text: "Lecture Level",
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
                            text: "Lecture Duration",
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
                                labelText: 'Lecture Duration',
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
                  onTap: () {
                    if (checkAllFields()) {

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
                          color: checkAllFields()
                              ? Colors.green
                              : Colors.grey,
                          width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GeneralAppIcon(
                          icon: Icons.file_upload_outlined,
                          size: 20,
                          color: checkAllFields()
                              ? Colors.green
                              : Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        PrimaryAppText(
                          text: 'Upload',
                          size: 16,
                          color: checkAllFields()
                              ? Colors.green
                              : Colors.grey,
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
    controller?.dispose();
    super.dispose();
  }
}
