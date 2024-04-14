import 'package:final_project/controllers/visit_controller.dart';
import 'package:final_project/models/backend_model.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class CreateVisit extends ConsumerStatefulWidget {
  const CreateVisit({super.key});

  @override
  ConsumerState<CreateVisit> createState() => _CreateVisitState();
}

class _CreateVisitState extends ConsumerState<CreateVisit> {
  DateTime visitDate = DateTime.now();
  TextEditingController visitDateController = TextEditingController();
  TextEditingController visitPurposeController = TextEditingController();
  TextEditingController visitPurposeDescriptionController =
      TextEditingController();
  TextEditingController visitLocationController = TextEditingController();
  TextEditingController visitTimeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    setState(() {
      if (picked != null && picked != visitDate) {
        final DateFormat formatter = DateFormat('dd-MMM-yyyy');
        visitDate = picked;
        visitDateController.text = formatter.format(visitDate);
      }
    });
  }

  bool checkAllFields() {
    if (visitDateController.text.isNotEmpty &&
        visitPurposeController.text.isNotEmpty &&
        visitPurposeDescriptionController.text.isNotEmpty &&
        visitTimeController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier).isLightMode;
    final visitController = Get.put(VisitController());
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: 'Schedule Visit',
          color: Colors.white,
          size: 20,
        ),
      ),
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
                          GeneralAppText(
                            text: 'Select Date',
                            size: 18,
                            color: theme ? Colors.black : Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                visitDateController.text = value;
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
                                labelText: 'Select Date',
                              ),
                              controller: visitDateController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: 'Select Time',
                            size: 18,
                            color: theme ? Colors.black : Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime,
                                  initialEntryMode: TimePickerEntryMode.input,
                                );
                                setState(() {
                                  visitTimeController.text =
                                      '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}';
                                });
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.access_time),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Select Time',
                              ),
                              controller: visitTimeController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: 'Set Location',
                            size: 18,
                            color: theme ? Colors.black : Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: visitLocationController,
                              onChanged: (value) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Set Location',
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Visit Purpose",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: visitPurposeController,
                              onChanged: (value) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Visit Purpose',
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralAppText(
                            text: "Visit Description",
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: visitPurposeDescriptionController,
                              maxLines: 5,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintMaxLines: 100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Visit Description',
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
                    Visit visit = Visit(
                        visitMentorId: "",
                        visitDate: visitDateController.text,
                        visitTime: visitTimeController.text,
                        visitLocation: visitLocationController.text,
                        visitPurpose: visitPurposeController.text,
                        visitDescription:
                            visitPurposeDescriptionController.text);
                    visitController.setVisit(visit);
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
                          icon: Icons.add,
                          size: 20,
                          color: checkAllFields() ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        PrimaryAppText(
                          text: 'Create Event',
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
}
