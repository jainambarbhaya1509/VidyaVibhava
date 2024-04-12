
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/services/notification_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:uuid/uuid.dart';
import '../models/backend_model.dart';

class VisitRepository extends GetxController{
  static VisitRepository get instance=> Get.find();
  final notificationService = NotificationService();
  final _db = FirebaseFirestore.instance;

  Future<void> setVisit(Visit visit) async {
    await _db.collection("Visit").add(visit.toJson()).whenComplete(
          () =>
          Get.snackbar("Success", "Video has been uploaded successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  void sendNotificationOfVisit(Visit visit, Iterable<Student> studentList) {
    for (final student in studentList) {
      if (student.deviceToken != null) {
        notificationService.sendPushNotification(
          student.deviceToken,
          "Visit scheduled by Mentor on ${visit.visitDate} at ${visit.visitTime}",
          "Visit At ${visit.visitLocation} \n Visit Purpose is ${visit.visitPurpose} \n ${visit.visitDescription}",
        );
      } else {
        print("Skipping notification for student with null device token: $student");
      }
    }
  }
}
