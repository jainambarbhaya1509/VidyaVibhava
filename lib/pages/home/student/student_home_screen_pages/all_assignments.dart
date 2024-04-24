import 'package:final_project/pages/home/student/cards/assignment_details.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/check_assignments.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';

class AllAssignments extends ConsumerStatefulWidget {
  const AllAssignments({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllAssignmentsState();
}

class _AllAssignmentsState extends ConsumerState<AllAssignments> {
  @override
  Widget build(BuildContext context) {
    Logger().e("here");
    final theme = ref.watch(settingsProvider.notifier);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: "All Assignments",
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: ListView.builder(
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: theme.isLightMode ? textColor2 : textColor1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (builder) {
                      return AssignmentDetails(
                        index: index,
                        title: assignments[index]['title'] as String,
                        description:
                            assignments[index]['description'] as String,
                        dueDate: assignments[index]['dueDate'] as String,
                        marks: assignments[index]['marks'] as String,
                      );
                    },
                  );
                },
                child: Container(
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
                      GeneralAppText(
                          text: assignments[index]['title'] as String,
                          size: 16),
                      const SizedBox(
                        height: 5,
                      ),
                      GeneralAppText(
                          text: assignments[index]['description'] as String,
                          size: 16),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: GeneralAppText(
                                text: "Marks: ${assignments[index]['marks']}",
                                size: 16,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          GeneralAppText(
                            text: assignments[index]['dueDate'] as String,
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
      ),
    );
  }
}
