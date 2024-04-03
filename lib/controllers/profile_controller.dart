import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid != null){
      return _userRepo.getUserDetails(uid);
    }else{
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getVideoData(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid != null){
      return _userRepo.getContinueWatching(uid);
    }else{
      Get.snackbar("Error", "Login to Continue");
    }
  }

  getMentorData(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid != null){
      print("Inside Controller ${uid}");
      return _userRepo.getMentorByMentorId(uid);
    }else{
      Get.snackbar("Error", "Login to Continue");
    }
  }
}