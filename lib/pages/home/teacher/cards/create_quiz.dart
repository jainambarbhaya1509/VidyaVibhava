import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/pages/home/teacher/teacher_operations/create_course.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

List<Map<String, dynamic>> listOfQuiz = [];

class CreateQuiz extends ConsumerStatefulWidget {
  final int questionIndex;
  final List<Map<String, dynamic>> quizList;
  const CreateQuiz({super.key, required this.questionIndex, required this.quizList});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateQuizState();
}

class _CreateQuizState extends ConsumerState<CreateQuiz> {
  TextEditingController quizQuestionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  List<String> options = [];

  @override
  Widget build(BuildContext context) {
    String? correctAnswer = options.isNotEmpty ? options.first : null;
    return Container(
      height: 700,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralAppText(
                text: "Question after video ${widget.questionIndex + 1}",
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: quizQuestionController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Question',
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GeneralAppText(
                text: "Options",
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: option1Controller,
                          decoration: InputDecoration(
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
                      const SizedBox(width: 20),
                      Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: option2Controller,
                          decoration: InputDecoration(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: option3Controller,
                          decoration: InputDecoration(
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
                      const SizedBox(width: 20),
                      Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: option4Controller,
                          onChanged: (String val){
                            setState(() {
                              options = [
                                option1Controller.text,
                                option2Controller.text,
                                option3Controller.text,
                                option4Controller.text
                              ];
                            });
                          },
                          decoration: InputDecoration(
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
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        options = [
                          option1Controller.text,
                          option2Controller.text,
                          option3Controller.text,
                          option4Controller.text
                        ];
                      })
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: PrimaryAppText(
                          text: "Update Options",
                          size: 15,
                          weight: FontWeight.bold,
                          color: primaryColor,
                        )),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              GeneralAppText(
                text: "Correct Answer",
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0.0),
                child: DropdownButtonFormField<String>(
                  value: correctAnswer,
                  onChanged: (String? value) {
                    correctAnswer = value!;
                  },
                  items: options.map<DropdownMenuItem<String>>((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Correct Answer",
                  ),
                ),
              ),

              // CREATE QUIZ BUTTON
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> addQuizQuestion = {
                    "id": widget.questionIndex.toString(),
                    "question": quizQuestionController.text,
                    "options": options.toList(),
                    "correctAnswer": correctAnswer!,
                  };
                  quizList.add(addQuizQuestion);
                  if (listOfQuiz
                      .where(
                          (element) => addQuizQuestion["id"] == element["id"])
                      .toList()
                      .isNotEmpty) {
                    Logger().i("Question already exists");
                  } else {
                    listOfQuiz.add(addQuizQuestion);
                    //quizList.add(addQuizQuestion);
<<<<<<< Updated upstream
                    Logger().i("Question added");

                    for (var module in courseModules) {
                      if (module["id"].toString() ==
                          widget.questionIndex.toString()) {
                        module["quiz"] = addQuizQuestion;
                      }
                    }
                    Logger().f(courseModules);
=======
>>>>>>> Stashed changes
                  }

                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: PrimaryAppText(
                    text: "Create Quiz",
                    size: 18,
                    color: primaryColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
