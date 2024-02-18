import 'dart:io';

import 'package:final_project/pages/signups/signup_pages/address_info.dart';
import 'package:final_project/pages/signups/signup_pages/organization_info.dart';
import 'package:final_project/pages/signups/signup_pages/personal_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stuent Providers
final stuentPersonalInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'fname': studentFnameController.text,
    'lname': studentLnameController.text,
    'dob': studentDobController.text,
    'gender': studentGenderController.text,
    'phone': studentPhoneController.text,
    'username': studentUsernameController.text,
  };
});
final studentSelectedGenderProvider = StateProvider<String?>((ref) => null);

final studentAddressInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'address': studentAddressController.text,
    'zipCode': studentZipCodeController.text,
    'city': studentCityController.text,
    'state': studentStateController.text,
  };
});

final studentImageProvider = StateProvider<File?>((ref) => null);
final studentAadharProvider = StateProvider<File?>((ref) => null);
final studentIncomeProvider = StateProvider<File?>((ref) => null);


// Teacher Providers
final teacherPersonalInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'fname': teacherFnameController.text,
    'lname': teacherLnameController.text,
    'dob': teacherDobController.text,
    'gender': teacherGenderController.text,
    'phone': teacherPhoneController.text,
    'email': teacherEmailController.text,
  };
});
final teacherSelectedGenderProvider = StateProvider<String?>((ref) => null);

final teacherAddressInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'address': teacherAddressController.text,
    'zipCode': teacherZipCodeController.text,
    'city': teacherCityController.text,
    'state': teacherStateController.text,
  };
});

final teacherImageProvider = StateProvider<File?>((ref) => null);
final teacherAadharProvider = StateProvider<File?>((ref) => null);
final teacherCertificateProvider = StateProvider<File?>((ref) => null);


final teacherOganizationInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'organization': organizationController.text,
    'cddaAffiliated': false,
    'subjects': [],
    'isMentor': false,
  };
});