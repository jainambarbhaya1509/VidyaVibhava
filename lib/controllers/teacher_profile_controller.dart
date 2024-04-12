import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TeacherProfileController extends GetxController {
  static TeacherProfileController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      return _userRepo.getTeacherUserDetails(uid);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getUserId(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      return uid;
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getUserFullName(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid!=null){
      return _userRepo.getTeacherFullName(uid);
    }
  }

  getVideoData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
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

  getImageData(String url){
    if(url!=null){
      return _userRepo.getImageData(url);
    }else{
      Get.snackbar("Error", "URL is empty");
    }
  }

  getInstructorDetailsToDisplay(String id){
    if(id!=null){
      return _userRepo.getInstructorDetailsToDisplay(id);
    }else{
      Get.snackbar("Error", "URL is empty");
    }
  }
}
