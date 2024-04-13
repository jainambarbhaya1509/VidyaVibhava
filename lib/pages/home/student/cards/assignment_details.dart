import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/keep/v1.dart';
import 'package:logger/web.dart';

class AssignmentDetails extends ConsumerStatefulWidget {
  final String title, description, dueDate, marks;
  final int index;
  const AssignmentDetails(
      {super.key,
      required this.index,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.marks});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssignmentDetailsState();
}

List uploadedFiles = [];

class _AssignmentDetailsState extends ConsumerState<AssignmentDetails> {
  Future uploadAssignments(int index) async {
    final assignment = ref.watch(assignmentProvider);
    Logger().i(assignment);
    final files = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (files != null) {
      setState(() {
        for (var file in files.files) {
          (assignment[index]['documents'] as List).add(file.name);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final assignment = ref.watch(assignmentProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Container(
              height: 5,
              width: 120,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GeneralAppText(
            text: widget.title,
            size: 20,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          GeneralAppText(
            text: widget.description,
            size: 15,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralAppText(
                  text: "Due Date: ${widget.dueDate}",
                  size: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: GeneralAppText(
                    text: "Marks: ${widget.marks}",
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => uploadAssignments(widget.index),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.78,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: (assignment[widget.index]['documents'] as List)
                              .isEmpty
                          ? Colors.grey
                          : Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      PrimaryAppText(
                        text: (assignment[widget.index]['documents'] as List)
                                .isEmpty
                            ? "Upload Assignments"
                            : "${(assignment[widget.index]['documents'] as List).length} Documents Uploaded",
                        size: 15,
                        color: (assignment[widget.index]['documents'] as List)
                                .isEmpty
                            ? Colors.grey
                            : Colors.green,
                      ),
                      const Spacer(),
                      GeneralAppIcon(
                        icon: (assignment[widget.index]['documents'] as List)
                                .isEmpty
                            ? Icons.upload
                            : Icons.check_circle_outline_rounded,
                        color: (assignment[widget.index]['documents'] as List)
                                .isEmpty
                            ? Colors.grey
                            : Colors.green,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if ((assignment[widget.index]['documents'] as List).isNotEmpty) {
                      (assignment[widget.index]['documents'] as List).clear();
                      setState(() {});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: GeneralAppText(
                            text: "No files to delete",
                            size: 15,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        GeneralAppIcon(icon: Icons.delete, color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: GeneralAppText(
              text: "Submit",
              size: 18,
              weight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
