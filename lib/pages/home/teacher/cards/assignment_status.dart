import 'dart:async';
import 'dart:io';

import 'package:final_project/pages/home/teacher/cards/assignment_document.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/check_assignments.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../../../controllers/teacher_profile_controller.dart';
import '../../../../models/backend_model.dart';

class AssignmentStatus extends ConsumerStatefulWidget {
  final String assignmentId;
  const AssignmentStatus({super.key, required this.assignmentId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssignmentStatusState();
}

List gradeStatus = ["All", "Submitted", "Pending", "Graded"];
String? selectedStatus = "All";

String getSubmissionStatus(AssignmentToGrade assignment) {
  if (assignment.assignmentDoc == "") {
    return "Pending";
  } else if (assignment.assignedGrade == "" && assignment.assignmentDoc != "") {
    return "Submitted";
  } else {
    return "Graded";
  }
}

class _AssignmentStatusState extends ConsumerState<AssignmentStatus> {
  late List<TextEditingController> gradeControllers;

  Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();

    //final assignments = ref.read(assignmentListProvider);
    //final studentsPerAssignment =assignments[int.parse(widget.assignmentId)]["students"];
    //gradeControllers = List.generate(studentsPerAssignment.length,(index) => TextEditingController(),);
  }

  @override
  void dispose() {
    for (final controller in gradeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    //final assignments = ref.watch(assignmentListProvider);
    //final studentsPerAssignment = assignments[int.parse(widget.assignmentId)]["students"];
    //final maxMarks = assignments[int.parse(widget.assignmentId)]["marks"];
    List<AssignmentToGrade> assignmentstoGradeList = [];
    final teacherController = Get.put(TeacherProfileController());

    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(
        top: 35,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 10),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: GeneralAppText(
                    text: "Submission Status",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: GeneralAppText(
                      text: "Close", size: 17, weight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 5),
            child: const StatusDropdown(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(right: 20, left: 10, top: 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: teacherController.getStudentAssignmentsToGrade(widget.assignmentId),
                  builder:(context, snapshot){

                    try {
                      if (snapshot.data != null) {
                        assignmentstoGradeList = snapshot.data as List<AssignmentToGrade>;
                        gradeControllers = List.generate(assignmentstoGradeList.length,(index) => TextEditingController(),);
                        print(gradeControllers);
                      }
                    } on Exception catch (e) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: assignmentstoGradeList.length,
                          itemBuilder: (context, index) {
                            AssignmentToGrade assignment = assignmentstoGradeList[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  margin: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: theme.isLightMode
                                        ? const Color.fromARGB(211, 228, 228, 228)
                                        : const Color.fromARGB(255, 54, 54, 54),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          SecondaryAppText(
                                            text: assignment.studentName!,
                                            size: 16,
                                            weight: FontWeight.bold,
                                          ),
                                          PrimaryAppText(
                                            text: getSubmissionStatus(assignment),
                                            size: 16,
                                            weight: FontWeight.bold,
                                            color: getSubmissionStatus(assignment) ==
                                                "Pending"
                                                ? const Color.fromARGB(
                                                255, 211, 195, 52)
                                                : getSubmissionStatus(assignment) ==
                                                "Submitted"
                                                ? const Color.fromARGB(
                                                255, 68, 193, 72)
                                                : const Color.fromARGB(
                                                255, 51, 145, 223),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (assignment.assignmentDoc != "") {
                                                /*fromAsset(studentsPerAssignment[index]["document"],
                                                    path.basename(studentsPerAssignment[index]["document"])).then((value) {*/
                                                print("Path to pdf file : ${assignment.assignmentDoc}");
                                                  Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>AssignmentDocument(pdfUrl: assignment.assignmentDoc,),
                                                    ),
                                                  );
                                                /*}).catchError((error) {
                                                  print("Error: $error");
                                                });*/
                                              }
                                            },
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width *
                                                  0.5,
                                              child: Row(
                                                children: [
                                                  GeneralAppIcon(
                                                    icon: Icons.picture_as_pdf_rounded,
                                                    color: theme.isLightMode
                                                        ? textColor1
                                                        : textColor2,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  GeneralAppText(
                                                    text: "View Document",
                                                    size: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 45,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: theme.isLightMode
                                                  ? const Color.fromARGB(
                                                  211, 228, 228, 228)
                                                  : const Color.fromARGB(
                                                  255, 68, 68, 68),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: TextFormField(
                                              //enabled: getSubmissionStatus(assignment) =="Submitted" ? true : false,
                                              controller: null,//gradeControllers[index],
                                              decoration: const InputDecoration(
                                                hintText: "Grade",
                                                border: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.only(left: 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                      if (assignment.assignedGrade == "") {
                                        if (int.parse(gradeControllers[index].text) > int.parse(assignment.maxGrade)) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Grade cannot be greater than the maximum marks"),
                                            ),
                                          );
                                        } else {
                                          assignment.assignedGrade = gradeControllers[index].text;
                                        }
                                      }
                                  },
                                  child: GeneralAppIcon(
                                      icon: Icons.check, color: primaryColor, size: 30),
                                ),
                              ],
                            );
                          },
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class StatusDropdown extends StatefulWidget {
  const StatusDropdown({super.key});

  @override
  State<StatusDropdown> createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  String? selectedStatus = gradeStatus.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedStatus,
      onChanged: (String? value) {
        setState(() {
          selectedStatus = value;
        });
      },
      items: gradeStatus
          .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                value: value,
                child: Text("$value"),
              ))
          .toList(),
    );
  }
}
