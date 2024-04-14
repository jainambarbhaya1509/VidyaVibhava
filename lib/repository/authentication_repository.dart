import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/backend_model.dart';
import 'package:final_project/pages/common/start_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ' '.obs;
  final _db = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late String? deviceToken;

  @override
  void onReady() {
    firebaseUser = _auth.currentUser as Rx<User?>;
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const StartScreen())
        : Get.offAll(() => const StudentHomeScreen());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    print("------------------------------" + phoneNo);
    String phoneNum = "+91" + phoneNo;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        verificationCompleted: (credentials) async {
          await _auth.signInWithCredential(credentials);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid');
          } else {
            Get.snackbar('Error', 'Something went wrong try again !');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        });

    deviceToken = await _firebaseMessaging.getToken();
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<Student> createStudent(
      Student student, File img, File doc1, File doc2) async {
    student.uid = _auth.currentUser?.uid;
    student.deviceToken = deviceToken!;
    await _db
        .collection("Users")
        .add(student.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Account has been created successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
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

  Future<Teacher> createTeacher(
      Teacher teacher, File img, File doc1, File doc2) async {
    teacher.uid = _auth.currentUser?.uid;
    teacher.deviceToken = deviceToken!;
    await _db
        .collection("Teachers")
        .add(teacher.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Account has been created successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });

    //uploadProfilePicture(img, student);
    //uploadAadharDocument(doc1, student);
    //uploadIncomeDocument(doc2, student);
    return teacher;
  }

  Future<void> uploadProfilePicture(File imageFile, Student user) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_documents/${user.uid}/${user.uid}_profile.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    Map<String, dynamic> updateData = {'image': downloadUrl};
    // Update user model with profile picture URL
    await _db.collection("Users").doc(user.uid).update(updateData);
    //user.image = downloadUrl;
  }

// Function to upload document to Firebase Storage and update user model
  Future<void> uploadAadharDocument(File documentFile, Student user) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_documents/${user.uid}/${documentFile.path}');
    final uploadTask = storageRef.putFile(documentFile);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> updateData = {'doc1': downloadUrl};
    // Update user model with profile picture URL
    await _db.collection("Users").doc(user.uid).update(updateData);
  }

  Future<void> uploadIncomeDocument(File documentFile, Student user) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_documents/${user.uid}/${documentFile.path}');
    final uploadTask = storageRef.putFile(documentFile);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> updateData = {'doc2': downloadUrl};
    // Update user model with profile picture URL
    await _db.collection("Users").doc(user.uid).update(updateData);
  }

  void signOut() {}

  Future<String> sendOTPToEmail(String email) async {
    String requestBody = jsonEncode(email);
    final response = await http.post(
      Uri.parse("http://127.0.0.1:5000/sendOTPtoEmail"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      // Request was successful, parse the response data
      print('Response body: ${response.body}');
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['generatedOtp'];
    } else {
      // Request failed, handle the error
      print('Failed to send data: ${response.statusCode}');
      return "Error Getting OTP";
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      deviceToken = await _firebaseMessaging.getToken();
    } catch (_) {}
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("Logging In");
      deviceToken = await _firebaseMessaging.getToken();
      print("Device Token : ${deviceToken}");
    } catch (_) {}
  }
}
