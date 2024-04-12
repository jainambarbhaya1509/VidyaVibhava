import 'dart:io';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/backend_model.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  void RegisterUser(String email, String password){
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  void LoginTeacher(String email, String password){
    AuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password);
  }

  void CreateTeacher(Teacher teacher, File img, File doc1, File doc2){
    AuthenticationRepository.instance.createTeacher(teacher, img, doc1, doc2);
  }
}