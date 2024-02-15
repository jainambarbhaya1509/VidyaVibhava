import 'dart:io';

import 'package:final_project/pages/signups/signup_pages/address_info.dart';
import 'package:final_project/pages/signups/signup_pages/organization_info.dart';
import 'package:final_project/pages/signups/signup_pages/personal_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final personalInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'fname': fnameController.text,
    'lname': lnameController.text,
    'dob': dobController.text,
    'gender': genderController.text,
    'phone': phoneController.text,
    'username': usernameController.text,
    'email': emailController.text,
  };
});
final selectedGenderProvider = StateProvider<String?>((ref) => null);

final addressInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'address': addressController.text,
    'zipCode': zipCodeController.text,
    'city': cityController.text,
    'state': stateController.text,
  };
});

final imageProvider = StateProvider<File?>((ref) => null);
final aadharProvider = StateProvider<File?>((ref) => null);
final incomeProvider = StateProvider<File?>((ref) => null);


final organizationInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'organization': organizationController.text,
    'cddaAffiliated': false,
    'subjects': [],
    'isMentor': false,
  };
});