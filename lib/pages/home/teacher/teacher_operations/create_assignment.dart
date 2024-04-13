import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreateAssignment extends ConsumerStatefulWidget {
  const CreateAssignment({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateAssignmentState();
}

class _CreateAssignmentState extends ConsumerState<CreateAssignment> {
  TextEditingController assignmentQuestionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController marksController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    DateTime dueDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    setState(() {
      if (picked != null && picked != dueDate) {
        final DateFormat formatter = DateFormat('dd-MMM-yyyy');
        dueDate = picked;
        dueDateController.text = formatter.format(dueDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                text: "Create Assignment",
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: assignmentQuestionController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralAppText(
                        text: "Due Date",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            dueDateController.text = value;
                          },
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          onTap: () => selectDate(context),
                          decoration: InputDecoration(
                            suffixIcon:
                                const Icon(Icons.calendar_month_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Select Date',
                          ),
                          controller: dueDateController,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralAppText(
                        text: "Marks",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            marksController.text = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Marks',
                          ),
                          controller: marksController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                    text: "Create Assignment",
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
