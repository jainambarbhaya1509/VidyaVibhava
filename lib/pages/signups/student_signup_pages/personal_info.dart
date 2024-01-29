import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final personalInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'fname': fnameController.text,
    'lname': lnameController.text,
    'dob': dobController.text,
    'gender': genderController.text,
    'phone': phoneController.text,
    'username': usernameController.text,
  };
});
final selectedGenderProvider = StateProvider<String?>((ref) => null);

DateTime selectedDate = DateTime.now();

TextEditingController dobController = TextEditingController();
TextEditingController fnameController = TextEditingController();
TextEditingController lnameController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController usernameController = TextEditingController();

class PersonalInformationSection extends ConsumerStatefulWidget {
  const PersonalInformationSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalInformationSectionState();
}

class _PersonalInformationSectionState
    extends ConsumerState<PersonalInformationSection> {
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

      dobController.text = formattedDate;
      ref.read(personalInfoProvider)['dob'] = formattedDate;
    }
  }

  List<String> genderOptions = ['Male', 'Female', 'Other'];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, top: 30, right: 30),
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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 160.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      onChanged: (value) {
                        ref.read(personalInfoProvider)['fname'] = value;
                      },
                      controller: fnameController,
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
                        ref.read(personalInfoProvider)['lname'] = value;
                      },
                      controller: lnameController,
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
                        ref.read(personalInfoProvider)['dob'] = value;
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
                      controller: dobController,
                    ),
                  ),
                  Container(
                    width: 160.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      value: ref.watch(selectedGenderProvider),
                      onChanged: (String? value) {
                        ref.read(selectedGenderProvider.notifier).state = value;
                        ref.read(personalInfoProvider)['gender'] = value;
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
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  ref.read(personalInfoProvider)['phone'] = value;
                },
                controller: phoneController,
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
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    ref.read(personalInfoProvider)['username'] = value;
                  },
                  controller: usernameController,
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
          ),
        ],
      ),
    );
  }
}



