// ignore_for_file: avoid_print

import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      return _userRepo.getUserDetails(uid);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getUserId() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      return uid;
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getUserFullName() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      return _userRepo.getTeacherFullName(uid);
    }
  }

  getVideoData() {
    print("Entered Video Data");
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      print("In Profile Controller ${uid}");
      return _userRepo.getContinueWatching(uid);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getMentorData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      print("Inside Controller ${uid}");
      return _userRepo.getMentorByMentorId(uid);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getStudentForMentorData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      print("Inside Controller ${uid}");
      return _userRepo.getStudentByMentorId(uid);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getImageData(String url) {
    if (url != null) {
      return _userRepo.getImageData(url);
    } else {
      Get.snackbar("Error", "URL is empty");
    }
  }

  getAssignmentData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      return _userRepo.getAssignmentByStudentId(uid);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }
}
