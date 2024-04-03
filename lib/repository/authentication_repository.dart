import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/backend_model.dart';
import 'package:final_project/pages/common/start_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class AuthenticationRepository extends GetxController
{
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ' '.obs;
  final _db = FirebaseFirestore.instance;

  @override
  void onReady()
  {
    firebaseUser = _auth.currentUser as Rx<User?>;
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user)
  {
    user == null ? Get.offAll(() => const StartScreen()) : Get.offAll(() => const StudentHomeScreen());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    print("------------------------------"+phoneNo);
    String phoneNum = "+91"+phoneNo;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        verificationCompleted: (credentials) async{
          await _auth.signInWithCredential(credentials);
        },
        verificationFailed: (e){
          if (e.code == 'invalid-phone-number'){
            Get.snackbar('Error', 'The provided phone number is not valid');
          }
          else{
            Get.snackbar('Error', 'Something went wrong try again !');
          }
        },
        codeSent: (verificationId, resendToken){
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationId.value = verificationId;
        }
    );
  }

  Future<bool> verifyOTP(String otp) async{
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<Student> createStudent(Student student, File img, File doc1, File doc2) async {
    student.uid = _auth.currentUser?.uid;
    await _db.collection("Users").add(student.toJson()).whenComplete(
          () => Get.snackbar("Success", "Account has been created successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),
    ).catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
    //String num = "+91"+student.phoneNo;
    //User? u = _auth.currentUser;
    //signInWithPhoneNumber(num);

    //uploadProfilePicture(img, student);
    //uploadAadharDocument(doc1, student);
    //uploadIncomeDocument(doc2, student);
    return student;
  }

  Future<void> uploadProfilePicture(File imageFile, Student user) async {
    final storageRef = FirebaseStorage.instance.ref().child('user_documents/${user.uid}/${user.uid}_profile.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    Map<String, dynamic> updateData = {'image':downloadUrl};
    // Update user model with profile picture URL
    await _db.collection("Users").doc(user.uid).update(updateData);
    //user.image = downloadUrl;
  }

// Function to upload document to Firebase Storage and update user model
  Future<void> uploadAadharDocument(File documentFile, Student user) async {
    final storageRef = FirebaseStorage.instance.ref().child('user_documents/${user.uid}/${documentFile.path}');
    final uploadTask = storageRef.putFile(documentFile);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> updateData = {'doc1':downloadUrl};
    // Update user model with profile picture URL
    await _db.collection("Users").doc(user.uid).update(updateData);
  }

  Future<void> uploadIncomeDocument(File documentFile, Student user) async {
    final storageRef = FirebaseStorage.instance.ref().child('user_documents/${user.uid}/${documentFile.path}');
    final uploadTask = storageRef.putFile(documentFile);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> updateData = {'doc2':downloadUrl};
    // Update user model with profile picture URL
    await _db.collection("Users").doc(user.uid).update(updateData);
  }

  void signOut() {}


}