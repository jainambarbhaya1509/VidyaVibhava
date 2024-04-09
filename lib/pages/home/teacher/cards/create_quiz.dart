import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateQuiz extends ConsumerStatefulWidget {
  final int questionIndex;
  const CreateQuiz({super.key, required this.questionIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateQuizState();
}

class _CreateQuizState extends ConsumerState<CreateQuiz> {

  final createQuiz = [
    {
      "question": "",
      "options": [],
      "correctAnswer": "",
    },
  ];


  @override
  Widget build(BuildContext context) {
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
                          onChanged: (value) {},
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
                          onChanged: (value) {},
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
                          onChanged: (value) {},
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
                          onChanged: (value) {},
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
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  value: "Option 1",
                  onChanged: (String? value) {},
                  items: [
                    "Option 1",
                    "Option 2",
                    "Option 3",
                    "Option 4",
                  ].map<DropdownMenuItem<String>>((String option) {
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
                onTap: () {},
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
