import 'package:final_project/providers/role_provider.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Stuent Text Controllers
DateTime studentSelectedDate = DateTime.now();

TextEditingController studentDobController = TextEditingController();
TextEditingController studentFnameController = TextEditingController();
TextEditingController studentLnameController = TextEditingController();
TextEditingController studentGenderController = TextEditingController();
TextEditingController studentPhoneController = TextEditingController();
TextEditingController studentUsernameController = TextEditingController();

// Teacher Text Controllers
DateTime teacherSelectedDate = DateTime.now();

TextEditingController teacherDobController = TextEditingController();
TextEditingController teacherFnameController = TextEditingController();
TextEditingController teacherLnameController = TextEditingController();
TextEditingController teacherGenderController = TextEditingController();
TextEditingController teacherPhoneController = TextEditingController();
TextEditingController teacherUsernameController = TextEditingController();
TextEditingController teacherEmailController = TextEditingController();

class PersonalInformationSection extends ConsumerStatefulWidget {
  const PersonalInformationSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalInformationSectionState();
}

class _PersonalInformationSectionState
    extends ConsumerState<PersonalInformationSection> {
  Future<void> selectDate(BuildContext context) async {
    final role = ref.read(roleProvider);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          role == 'student' ? studentSelectedDate : teacherSelectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null &&
        picked !=
            (role == 'student' ? studentSelectedDate : teacherSelectedDate)) {
      if (role == 'student') {
        studentSelectedDate = picked;
      } else {
        teacherSelectedDate = picked;
      }
      if (role == 'student') {
        studentDobController.text =
            DateFormat('dd-MM-yyyy').format(studentSelectedDate);
      } else {
        teacherDobController.text =
            DateFormat('dd-MM-yyyy').format(teacherSelectedDate);
      }

      if (role == 'student') {
        ref.read(stuentPersonalInfoProvider)['dob'] = studentDobController.text;
      } else {
        ref.read(teacherPersonalInfoProvider)['dob'] =
            teacherDobController.text;
      }
      if (role == 'student') {
        ref.read(stuentPersonalInfoProvider)['dob'] = studentDobController.text;
      } else {
        ref.read(teacherPersonalInfoProvider)['dob'] =
            teacherDobController.text;
      }
    }
  }

  List<String> genderOptions = ['Male', 'Female', 'Other'];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    final role = ref.read(roleProvider);
    return Container(
      margin: const EdgeInsets.only(
        left: 30,
        top: 30,
        right: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppText(
            text: "Personal Information",
            size: 20,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      if (role == 'student') {
                        ref.read(stuentPersonalInfoProvider)['fname'] = value;
                      } else {
                        ref.read(teacherPersonalInfoProvider)['fname'] = value;
                      }
                    },
                    controller: role == 'student'
                        ? studentFnameController
                        : teacherFnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'First Name',
                    ),
                  ),
                ),
                Container(
                  width: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      if (role == 'student') {
                        ref.read(stuentPersonalInfoProvider)['lname'] = value;
                      } else {
                        ref.read(teacherPersonalInfoProvider)['lname'] = value;
                      }
                    },
                    controller: role == 'student'
                        ? studentLnameController
                        : teacherLnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Last Name',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      if (role == 'student') {
                        ref.read(stuentPersonalInfoProvider)['dob'] = value;
                      } else {
                        ref.read(teacherPersonalInfoProvider)['dob'] = value;
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () => selectDate(context),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Date of Birth',
                    ),
                    controller: role == 'student'
                        ? studentDobController
                        : teacherDobController,
                  ),
                ),
                Container(
                  width: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: role == 'student'
                        ? ref.watch(studentSelectedGenderProvider)
                        : ref.watch(teacherSelectedGenderProvider),
                    onChanged: (String? value) {
                      if (role == 'student') {
                        ref.read(studentSelectedGenderProvider.notifier).state =
                            value;
                        ref.read(stuentPersonalInfoProvider)['gender'] = value;
                      } else {
                        ref.read(teacherSelectedGenderProvider.notifier).state =
                            value;
                        ref.read(teacherPersonalInfoProvider)['gender'] = value;
                      }
                    },
                    items: genderOptions
                        .map<DropdownMenuItem<String>>((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Gender",
                    ),
                  ),
                ),
              ],
            ),
            if (role == 'teacher') ...[
              const SizedBox(
                height: 15,
              ),
              TextField(
                onChanged: (value) {
                  ref.read(teacherPersonalInfoProvider)['phone'] = value;
                },
                controller: teacherPhoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Phone Number',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      '+91 |',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ],
            if (role == 'student') ...[
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    ref.read(stuentPersonalInfoProvider)['username'] = value;
                  },
                  controller: studentUsernameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Username',
                  ),
                ),
              ),
            ],
          ]),
        ],
      ),
    );
  }
}
