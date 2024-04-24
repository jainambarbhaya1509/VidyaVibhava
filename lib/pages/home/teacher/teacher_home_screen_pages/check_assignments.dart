import 'package:final_project/pages/home/teacher/cards/assignment_status.dart';
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

final assignmentListProvider = StateProvider((ref) => assignmentList);
List assignmentList = [
  {
    "id": "0",
    'subject': 'History',
    "title":
        "Summary on the history of india by the british empire with respect yo its impact on the economy",
    "marks": 100,
    "date": "12/12/2024",
    "students": [
      {
        "username": "jainambarbhaya",
        "gradeStatus": false,
        "document": null,
      },
      {
        "username": "chintandodia",
        "gradeStatus": false,
        "document": null,
      },
    ]
  },
  {
    "id": "1",
    'subject': 'History',
    "title":
        "Summary on the history of india by the british empire with respect yo its impact on the economy",
    "marks": 100,
    "date": "12/12/2024",
    "students": [
      {
        "username": "jainambarbhaya",
        "gradeStatus": false,
        "document": "assets/pdf/test.pdf",
      },
      {
        "username": "chintandodia",
        "gradeStatus": false,
        "document": "assets/pdf/test2.pdf",
      },
      {
        "username": "khushisanghavi",
        "gradeStatus": false,
        "document": null,
      },
    ]
  },
  {
    "id": "2",
    'subject': 'History',
    "title":
        "Summary on the history of india by the british empire with respect yo its impact on the economy",
    "marks": 100,
    "date": "12/12/2024",
    "students": [
      {
        "username": "jainambarbhaya",
        "gradeStatus": false,
        "document": null,
      },
      {
        "username": "khushisanghavi",
        "gradeStatus": false,
        "document": null,
      },
    ]
  },
  {
    "id": "3",
    'subject': 'History',
    "title":
        "Summary on the history of india by the british empire with respect yo its impact on the economy",
    "marks": 100,
    "date": "12/12/2024",
    "students": [
      {
        "username": "architjain",
        "gradeStatus": false,
        "document": null,
      },
      {
        "username": "chintandodia",
        "gradeStatus": false,
        "document": null,
      },
    ]
  },
  {
    "id": "4",
    'subject': 'History',
    "title":
        "Summary on the history of india by the british empire with respect yo its impact on the economy",
    "marks": 100,
    "date": "12/12/2024",
    "students": [
      {
        "username": "jainambarbhaya",
        "gradeStatus": false,
        "document": null,
      },
      {
        "username": "chintandodia",
        "gradeStatus": false,
        "document": null,
      },
      {
        "username": "architjain",
        "gradeStatus": false,
        "document": null,
      },
    ]
  }
];

// Map<String, dynamic> assignment = {
//   "id": "0",
//   "title":
//       "Summary on the history of india by the british empire with respect yo its impact on the economy",
//   "marks": 100,
//   "date": "12/12/2024",
//   "students": [
//     {
//       "username": "jainambarbhaya",
//       "gradeStatus": true,
//       "document": null,
//       "grade": 10,
//     },
//     {
//       "username": "chintandodia",
//       "gradeStatus": false,
//       "document": null,
//       "grade": 10,
//     },
//   ]
// };

class CheckAssignments extends ConsumerStatefulWidget {
  const CheckAssignments({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckAssignmentsState();
}

class _CheckAssignmentsState extends ConsumerState<CheckAssignments> {
  @override
  Widget build(BuildContext context) {
    final assignmentList = ref.watch(assignmentListProvider);
    Logger().f(assignmentList);
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
                  itemCount: assignmentList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (builder) {
                            return AssignmentStatus(
                              assignmentId: index.toString(),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralAppText(
                              text: assignmentList[index]["subject"],
                              size: 17,
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GeneralAppText(
                                text: assignmentList[index]["title"], size: 16),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: GeneralAppText(
                                      text:
                                          "Marks: ${assignmentList[index]["marks"]}",
                                      size: 15,
                                      // weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GeneralAppText(
                                  text: "${assignmentList[index]["date"]}",
                                  size: 15,
                                  // weight: FontWeight.bold,
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
