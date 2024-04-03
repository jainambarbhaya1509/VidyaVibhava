
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/backend_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  late Rx<Student?> student; // Declare a Rx variable to hold the student data

  @override
  void onInit() {
    super.onInit();
    // Initialize the student variable when the repository is initialized
    student = Rx<Student?>(null);
  }

  Future<Student> getUserDetails(String id) async {
    final snapshot = await _db.collection('Users').where("uid", isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => Student.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<Student>> getAllUsers(String id) async {
    final snapshot = await _db.collection('Users').where("uid", isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => Student.fromSnapshot(e)).toList();
    return userData;
  }



  Future<String?> getUserFirstName(String id) async {
    final snapshot = await _db.collection("Users").where(
        "uid", isEqualTo: id).get();
    print(snapshot);
    final userData = snapshot.docs.map((e) => Student.fromSnapshot(e))
        .toList();
    print(userData.length);
    print(userData.single.firstName);
    if (userData.isNotEmpty) {
      return userData.single.firstName;
    }
  }

  /*Future<List<Video>> getContinueWatching(String id) async {
    final snapshot = await _db.collection('Users').where("uid", isEqualTo: id).get();
    if(snapshot.docs.isNotEmpty)
      {
        final userDoc = snapshot.docs.first;
        final continueWatchingSnapshot = await userDoc.reference.collection('ContinueWatching').get();

        final List<Video> continueWatchingList = continueWatchingSnapshot.docs.map((doc){
          final data = doc.data() as Map<String, dynamic>;
          return getVideo(data["videoId"]);
        }).cast<Video>().toList();

        return continueWatchingList;
      }else{
      return [];
    }
  }

  Future<Video> getVideo(String videoId) async {
    final snapshot = await _db.collection('VideoDetails').where("videoId", isEqualTo: videoId).get();
    final userData = snapshot.docs.map((e) => Video.fromSnapshot(e)).single;
    return userData;
  }*/

  Future<List<Video>> getContinueWatching(String id) async {
    final snapshot = await _db.collection('Users').where("uid", isEqualTo: id).get();
    if(snapshot.docs.isNotEmpty) {
      final userDoc = snapshot.docs.first;
      final continueWatchingSnapshot = await userDoc.reference.collection('ContinueWatching').get();

      final List<Future<Video>> continueWatchingList = continueWatchingSnapshot.docs.map((doc) async {
        final data = doc.data() as Map<String, dynamic>;
        return await getVideo(data["videoId"]); // Await the result of getVideo function
      }).toList();

      // Wait for all videos to be fetched
      final List<Video> videos = await Future.wait(continueWatchingList);

      return videos;
    } else {
      return [];
    }
  }

  Future<Video> getVideo(String videoId) async {
    final snapshot = await _db.collection('VideoDetails').where("videoId", isEqualTo: videoId).get();
    final userData = snapshot.docs.map((e) => Video.fromSnapshot(e)).single;
    return userData;
  }
  Future<Mentor> getMentorByMentorId(String userId) async {
    final querySnapshot = await _db.collection('Users').where(
        'uid', isEqualTo: userId).get();
    final userDocument = querySnapshot.docs.first;
    final mentorId = userDocument.data()['mentorId'];
    final mentorSnapshot = await _db.collection('Mentors').where(
        'mentorId', isEqualTo: mentorId).get();
    final mentorData = mentorSnapshot.docs
        .map((e) => Mentor.fromSnapshot(e))
        .single;
    print("Inside the user repo : ${mentorData.mentorName}");
    return mentorData;
  }

}