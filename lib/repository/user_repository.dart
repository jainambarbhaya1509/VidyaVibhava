import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/repository/video_repository.dart';
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
    final snapshot =
        await _db.collection('Users').where("uid", isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => Student.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<Student>> getAllUsers(String id) async {
    final snapshot =
        await _db.collection('Users').where("uid", isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => Student.fromSnapshot(e)).toList();
    return userData;
  }

  /*Future<Teacher> getTeacherUserDetails(String id) async {
    //print("Passed Id ${id}");
    final snapshot = await _db.collection('Teachers').where("uid", isEqualTo: id).get();
      //print("HAHAHAH ${snapshot}");
    Teacher userData = snapshot.docs.map((e) => Teacher.fromSnapshot(e)).single;
      //print("HAHAHAHUSERDATA ${userData}");

    return userData;
  }*/

  Future<Teacher> getTeacherUserDetails(String id) async {
    //print("Passed Id ${id}");
    try {
      final snapshot =
          await _db.collection('Teachers').where("uid", isEqualTo: id).get();
      //print("Snapshot: $snapshot");

      if (snapshot.docs.isEmpty) {
        throw Exception("No documents found for the provided ID");
      }

      Teacher userData =
          snapshot.docs.map((e) => Teacher.fromSnapshot(e)).single;

      return userData;
    } catch (e) {
      //print("Error fetching teacher details: $e");
      rethrow; // Rethrow the caught error for further handling
    }
  }

  Future<List<Teacher>> getAllTeacherUsers(String id) async {
    final snapshot =
        await _db.collection('Teachers').where("uid", isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => Teacher.fromSnapshot(e)).toList();
    return userData;
  }

  Future<String?> getTeacherFullName(String id) async {
    final snapshot =
        await _db.collection("Teachers").where("uid", isEqualTo: id).get();
    //print(snapshot);
    final userData = snapshot.docs.map((e) => Teacher.fromSnapshot(e)).toList();
    //print(userData.length);
    //print(userData.single.firstName);
    if (userData.isNotEmpty) {
      return (userData.single.firstName + " " + userData.single.lastName);
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

  /*Future<List<Video>> getContinueWatching(String id) async {
    //print("In user repo ${id}");
    final snapshot =
        await _db.collection('Users').where("uid", isEqualTo: id).get();
    if (snapshot.docs.isNotEmpty) {
      final userDoc = snapshot.docs.first;
      final continueWatchingSnapshot =
          await userDoc.reference.collection('ContinueWatching').get();

      final List<Future<Video>> continueWatchingList =
          continueWatchingSnapshot.docs.map((doc) async {
        final data = doc.data() as Map<String, dynamic>;
        return await getVideo(
            data["videoId"]); // Await the result of getVideo function
      }).toList();
      //print("Continue Watching : ${continueWatchingList.length}");
      // Wait for all videos to be fetched
      final List<Video> videos = await Future.wait(continueWatchingList);
      //print("In user repo $videos");
      return videos;
    } else {
      //print("In user repo else encountered");
      return [];
    }
  }*/

  Future<List<Video>> getContinueWatching(String id) async {
    //print("In user repo $id");
    final snapshot =
        await _db.collection('Users').where("uid", isEqualTo: id).get();
    if (snapshot.docs.isNotEmpty) {
      final userDoc = snapshot.docs.first;
      final continueWatchingSnapshot =
          await userDoc.reference.collection('ContinueWatching').get();

      final List<Future<Video>> continueWatchingList =
          continueWatchingSnapshot.docs.map((doc) async {
        final data = doc.data() as Map<String, dynamic>;
        return await getVideo(
            data["videoId"]); // Await the result of getVideo function
      }).toList();
      //print("Continue Watching : ${continueWatchingList.length}");

      // Wait for all videos to be fetched
      final List<Video> videos =
          (await Future.wait(continueWatchingList)).whereType<Video>().toList();
      //print("In user repo $videos");
      return videos;
    } else {
      //print("In user repo else encountered");
      return [];
    }
  }

  /*Future<Video> getVideo(String videoId) async {
    final snapshot = await _db
        .collection('VideoDetails')
        .where("videoId", isEqualTo: videoId)
        .get();
    final userData = snapshot.docs.map((e) => Video.fromSnapshot(e)).single;
    userData.thumbnailImage = (await FirebaseStorage.instance
        .refFromURL(userData.thumbnail)
        .getData())!;
    return userData;
  }*/

  Future<Video> getVideo(String videoId) async {
    try {
      final snapshot = await _db
          .collection('VideoDetails')
          .where("videoId", isEqualTo: videoId)
          .get();
      //print("Snapshot Printing : ${snapshot.docs.first.data()}");
      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.map((e) => Video.fromSnapshot(e)).single;
        userData.thumbnailImage = (await FirebaseStorage.instance
            .refFromURL(userData.thumbnail)
            .getData())!;
        //print(userData.toJson());
        return userData;
      } else {
        // Handle the case when the document is not found
        //print('Document with videoId $videoId not found in VideoDetails collection.');
        throw Null;
      }
    } catch (e) {
      // Handle any errors that might occur
      //print('Error in getVideo function: $e');
      rethrow;
    }
  }

  Future<Teacher> getMentorByMentorId(String userId) async {
    //print("Inside getMentorByMentorId");
    final querySnapshot =
        await _db.collection('Users').where('uid', isEqualTo: userId).get();
    final userDocument = querySnapshot.docs.first;
    final mentorId = userDocument.data()['mentorId'];
    final mentorSnapshot = await _db
        .collection('Teachers')
        .where('isMentor', isEqualTo: true)
        .where('uid', isEqualTo: mentorId)
        .get();
    final mentorData =
        mentorSnapshot.docs.map((e) => Teacher.fromSnapshot(e)).single;
    //print("Inside the user repo : ${mentorData.firstName}");
    return mentorData;
  }

  Future<Iterable<Student>> getStudentByMentorId(String userId) async {
    final querySnapshot = await _db
        .collection('Users')
        .where('mentorId', isEqualTo: userId)
        .get();

    final studentData = querySnapshot.docs.map((e) => Student.fromSnapshot(e));
    return studentData;
  }

  Future<Uint8List?> getImageData(String imageUrl) async {
    try {
      // Fetch data from Firebase Storage URL
      Uint8List? imageData =
          await FirebaseStorage.instance.refFromURL(imageUrl).getData();

      return imageData;
    } catch (error) {
      // Handle any errors that might occur during data fetching
      //print('Error fetching image data: $error');
      // Return null or rethrow the error based on your requirements
      return null;
    }
  }

  Future<List<Uint8List>> getInstructorVideoImage(String id) async {
    List<Uint8List> imageList = [];
    final snapshot = await _db
        .collection("VideoDetails")
        .where("instructorId", isEqualTo: id)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final videoList = snapshot.docs.map((e) => Video.fromSnapshot(e));
      for (final video in videoList) {
        final image = await getImageData(video.thumbnail);
        imageList.add(image!);
      }
    }
    return imageList;
  }

  Future<Visit> getInstructorVisitSchedule(String id) async {
    final now = DateTime.now();
    final twoWeeksFromNow = now.add(Duration(days: 14));
    final currentDateString = now.toIso8601String().substring(0, 10);
    final twoWeeksFromNowString =
        twoWeeksFromNow.toIso8601String().substring(0, 10);
    final snapshot = await _db
        .collection("Visit")
        .where("visitMentorId", isEqualTo: id)
        .where("visitDate", isGreaterThanOrEqualTo: currentDateString)
        .where("visitDate", isLessThanOrEqualTo: twoWeeksFromNowString)
        .get();

    final visit = snapshot.docs.map((e) => Visit.fromSnapshot(e)).single;
    return visit;
  }

  Future<Map<String, dynamic>> getInstructorDetailsToDisplay(String id) async {
    //print("Entered user repo----------------------->");
    final snapshot =
        await _db.collection("Teachers").where("uid", isEqualTo: id).get();
    final instructorDetail = <String, dynamic>{};

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final image = data["image"];
      //print("Image URL : $image");
      final id = data["uid"];
      final name = data["firstName"] + " " + data["lastName"];
      final orgName = data["organizationName"];
      final videoImageListFuture =
          getInstructorVideoImage(id); // Assuming this returns some data
      Visit visitData = await getInstructorVisitSchedule(
          id); // Assuming this returns some data
      final videoImageList = await videoImageListFuture;
      instructorDetail.addAll({
        "image": image,
        "id": id,
        "name": name,
        "orgName": orgName,
        "videoImageList": videoImageList,
        "visitData": visitData,
      });
    }
    return instructorDetail;
  }

  Future<bool> createAssignment(Assignment assignment, String uid) async {
    assignment.creatorId = uid;
    assignment.assignmentId = VideoRepository().generateRandomUid();

    try {
      // add assignment to assignment collection
      await _db.collection("Assignment").add(assignment.toJson());
      //update Associated Users
      final data = {
        "assignmentId" : assignment.assignmentId,
        "isSubmitted":false
      };
      final snapshot = await _db.collection("Users").where("mentorId",isEqualTo: uid).get();
      for(final doc in snapshot.docs){
        await doc.reference.collection("Assignments").add(data);
      }
      // If the assignment is added successfully, return true
      return true;
    } catch (error) {
      // If there's an error, print the error message and return false
      print("Error adding assignment: $error");
      return false;
    }
  }

  Future<List<Assignment>> getAssignmentByStudentId(String uid) async {
    final List<Assignment> assignmentList = [];
    final snapshot =
        await _db.collection('Users').where("uid", isEqualTo: uid).get();
    if (snapshot.docs.isNotEmpty) {
      final userDoc = snapshot.docs.first;
      final userAssignmentSnapshot =
          await userDoc.reference.collection('Assignments').get();

      for(final assignment in userAssignmentSnapshot.docs){
        final AssignmentSnapshot = await _db.collection("Assignment").where("assignmentId", isEqualTo: assignment.data()["assignmentId"]).get();
        assignmentList.addAll(AssignmentSnapshot.docs.map((e) => Assignment.fromSnapshot(e)));
      }
      return assignmentList;
    } else {
    //print("In user repo else encountered");
    return [];
    }
  }
}
