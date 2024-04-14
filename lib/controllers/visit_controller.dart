import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:final_project/repository/video_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/backend_model.dart';
import '../repository/visit_repository.dart';

class VisitController extends GetxController {
  static VisitController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  final _visitRepo = Get.put(VisitRepository());

  setVisit(Visit visit) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      visit.visitMentorId = uid;
      //_visitRepo.setVisit(visit);
      final studentList = await _userRepo.getStudentByMentorId(uid);
      _visitRepo.sendNotificationOfVisit(visit, studentList);
    }
  }
}
