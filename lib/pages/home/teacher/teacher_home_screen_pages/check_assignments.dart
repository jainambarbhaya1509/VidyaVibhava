import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/keep/v1.dart';
import 'package:logger/web.dart';

List assignments = [
  {
    "title":
        "Summary on the history of india by the british empire with respect yo its impact on the economy",
    "marks": 10,
    "date": "12/12/2024",
    "students": [
      {
        "name": "jainambarbhaya",
        "status": "Submitted",
        "grade": 10,
      },
      {
        "name": "jainambarbhaya",
        "status": "Submitted",
        "grade": 10,
      },
    ]
  },
];

class CheckAssignments extends ConsumerStatefulWidget {
  const CheckAssignments({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckAssignmentsState();
}

List submissionStatus = ["All", "Submitted", "Pending"];
String? selectedStatus = "All";

class _CheckAssignmentsState extends ConsumerState<CheckAssignments> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 40, left: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppText(
              text: "Grade Assignments",
              size: 20,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.isLightMode
                    ? const Color.fromARGB(211, 228, 228, 228)
                    : const Color.fromARGB(255, 54, 54, 54),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: null,
                decoration: const InputDecoration(
                  hintText: "search with a keyword",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (builder) {
                            return Container(
                              // width: double.infinity,
                              color: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.only(
                                left: 5,
                                top: 40,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 10, left: 5),
                                    alignment: Alignment.centerLeft,
                                    child: GeneralAppText(
                                      text: "Submission Status",
                                      size: 20,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // dropdown filters
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GeneralAppText(text: "Apply Filters", size: 17, weight: FontWeight.bold),
                                      const SubmissionStatusDropdown(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 25),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.85,
                                        // height: double.infinity,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          // shrinkWrap: true,
                                          itemCount: 20,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: theme.isLightMode
                                                        ? const Color.fromARGB(
                                                            211, 228, 228, 228)
                                                        : const Color.fromARGB(
                                                            255, 54, 54, 54),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.5,
                                                            child:
                                                                SecondaryAppText(
                                                              text:
                                                                  "jainambarbhaya",
                                                              size: 16,
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          PrimaryAppText(
                                                            text: "Submitted",
                                                            size: 16,
                                                            weight:
                                                                FontWeight.bold,
                                                            color: Colors.green,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5,
                                                              child: Row(
                                                                children: [
                                                                  GeneralAppIcon(
                                                                    icon: Icons
                                                                        .picture_as_pdf_rounded,
                                                                    color: theme
                                                                            .isLightMode
                                                                        ? textColor1
                                                                        : textColor2,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  GeneralAppText(
                                                                    text:
                                                                        "Check",
                                                                    size: 16,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              width: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: theme
                                                                        .isLightMode
                                                                    ? const Color
                                                                        .fromARGB(
                                                                        211,
                                                                        228,
                                                                        228,
                                                                        228)
                                                                    : const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        68,
                                                                        68,
                                                                        68),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    null,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      "Grade",
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              10),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                GeneralAppIcon(
                                                    icon: Icons.check,
                                                    color: primaryColor,
                                                    size: 30),
                                              ],
                                            );
                                          },
                                        ),
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
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: theme.isLightMode
                              ? const Color.fromARGB(211, 228, 228, 228)
                              : const Color.fromARGB(255, 54, 54, 54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            GeneralAppText(
                                text:
                                    "Summary on the history of india by the british empire with respect yo its impact on the economy",
                                size: 16),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: GeneralAppText(
                                    text: "Marks: 10",
                                    size: 16,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                GeneralAppText(
                                  text: "12/12/2024",
                                  size: 16,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class SubmissionStatusDropdown extends StatefulWidget {
  const SubmissionStatusDropdown({super.key});

  @override
  _SubmissionStatusDropdownState createState() => _SubmissionStatusDropdownState();
}

class _SubmissionStatusDropdownState extends State<SubmissionStatusDropdown> {
  String? selectedStatus = submissionStatus.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedStatus,
      onChanged: (String? value) {
        setState(() {
          selectedStatus = value;
        });
      },
      items: submissionStatus
          .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text("$value"),
                  ))
          .toList(),
    );
  }
}