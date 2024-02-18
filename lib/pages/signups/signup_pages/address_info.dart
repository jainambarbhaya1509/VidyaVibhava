import 'package:final_project/providers/role_provider.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressInformationSection extends ConsumerStatefulWidget {
  const AddressInformationSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddressInformationSectionState();
}

class _AddressInformationSectionState
    extends ConsumerState<AddressInformationSection> {
  @override
  Widget build(BuildContext context) {
    return buildAddressInformationSection(context);
  }
}

// Stuent Address Information
TextEditingController studentAddressController = TextEditingController();
TextEditingController studentCityController = TextEditingController();
TextEditingController studentStateController = TextEditingController();
TextEditingController studentZipCodeController = TextEditingController();
TextEditingController studentCountryController = TextEditingController();

// Teacher Address Information
TextEditingController teacherAddressController = TextEditingController();
TextEditingController teacherCityController = TextEditingController();
TextEditingController teacherStateController = TextEditingController();
TextEditingController teacherZipCodeController = TextEditingController();
TextEditingController teacherCountryController = TextEditingController();

Widget buildAddressInformationSection(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final role = ref.watch(roleProvider);
      return Container(
        margin: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppText(
              text: "Address Information",
              size: 20,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: role == 'student'
                  ? studentAddressController
                  : teacherAddressController,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                if (role == 'student') {
                  ref.read(studentAddressInfoProvider)['address'] = value;
                } else {
                  ref.read(teacherAddressInfoProvider)['address'] = value;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: role == 'student'
                  ? studentZipCodeController
                  : teacherZipCodeController,
              decoration: InputDecoration(
                labelText: "Zip Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                if (role == 'student') {
                  ref.read(studentAddressInfoProvider)['zipCode'] = value;
                } else {
                  ref.read(teacherAddressInfoProvider)['zipCode'] = value;
                }
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: role == 'student'
                  ? studentCityController
                  : teacherCityController,
              decoration: InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                if (role == 'student') {
                  ref.read(studentAddressInfoProvider)['city'] = value;
                } else {
                  ref.read(teacherAddressInfoProvider)['city'] = value;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: role == 'student'
                  ? studentStateController
                  : teacherStateController,
              decoration: InputDecoration(
                labelText: "State",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                if (role == 'student') {
                  ref.read(studentAddressInfoProvider)['state'] = value;
                } else {
                  ref.read(teacherAddressInfoProvider)['state'] = value;
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
