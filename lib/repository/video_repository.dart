import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:uuid/uuid.dart';
import '../models/backend_model.dart';

class VideoRepository extends GetxController {
  static VideoRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  String generateRandomUid() {
    const String _chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random _random = Random();

    // Generate a random string of length 10 by selecting characters randomly from _chars
    return String.fromCharCodes(Iterable.generate(
        10, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));
  }

  /*Future<void> uploadVideo(PlatformFile file, String? id, String docId) async {
    final uploadTask = FirebaseStorage.instance
        .ref()
        .child('videos/${id}')
        .putFile(File(file.path!));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> updateData = {'videoLoc': downloadUrl};
    await _db.collection("VideoDetails").doc(docId).update(updateData);
  }*/

  /*Future<void> uploadVideo(PlatformFile file, String? id, String docId) async {
    try {
      // Ensure file path is not null
      if (file.path == null) {
        throw Exception("File path is null");
      }

      // Upload file to Firebase Storage
      final uploadTask = FirebaseStorage.instance
          .ref()
          .child('videos/${id}.mp4');
      // Wait for upload to complete
      final TaskSnapshot snapshot = await uploadTask.putFile(File(file.path!));;

      // Get download URL of the uploaded file
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore document with the download URL
      await FirebaseFirestore.instance
          .collection("VideoDetails")
          .doc(docId)
          .update({'videoLoc': downloadUrl});
    } catch (e) {
      // Handle errors
      print("Error uploading video: $e");
      // You might want to show a snackbar or display an error message to the user
    }
  }

  Future<void> createVideoDocument(Video video, PlatformFile lectureVideo, [File? img]) async {
    video.videoId = Uuid().v4();
    DocumentReference documentReference = await _db.collection("VideoDetails").add(video.toJson()).whenComplete(
          () => Get.snackbar("Success", "Video has been uploaded successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });

    await uploadVideo(lectureVideo, video.videoId, documentReference.id);
  }*/

  Future<void> uploadVideo(PlatformFile file, String? id, String docId) async {
    try {
      print("Starting video upload...");

      // Ensure file path is not null
      if (file.path == null) {
        throw Exception("File path is null");
      }
      print("File path: ${file.path}");

      // Upload file to Firebase Storage
      final uploadTask =
          FirebaseStorage.instance.ref().child('videos/${id}.mp4');
      print("Upload task created");

      // Wait for upload to complete
      final metadata = SettableMetadata(contentType: 'video/mp4');
      final TaskSnapshot snapshot =
          await uploadTask.putFile(File(file.path!), metadata);
      print("Upload completed");

      // Get download URL of the uploaded file
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Download URL: $downloadUrl");

      // Update Firestore document with the download URL
      await FirebaseFirestore.instance
          .collection("VideoDetails")
          .doc(docId)
          .update({'videoLoc': downloadUrl});
      print("Firestore document updated");

      Reference ref = FirebaseStorage.instance.refFromURL(downloadUrl);

      // Retrieve the metadata of the file
      FullMetadata metadataa = await ref.getMetadata();

      // Print or handle the metadata as needed
      print("Metadata:");
      print("Content Type: ${metadataa.contentType}");
      print("Creation Time: ${metadataa.timeCreated}");
      print("Updated Time: ${metadataa.updated}");
    } catch (e) {
      // Handle errors
      print("Error uploading video: $e");
      // You might want to show a snackbar or display an error message to the user
    }
  }

  Future<void> createVideoDocument(Video video, PlatformFile lectureVideo,
      [File? img]) async {
    try {
      print("Creating video document...");

      video.videoId = Uuid().v4();
      print("Generated video ID: ${video.videoId}");

      DocumentReference documentReference =
          await _db.collection("VideoDetails").add(video.toJson());
      print("Firestore document created: ${documentReference.id}");

      await uploadVideo(lectureVideo, video.videoId, documentReference.id);
      print("Video upload process initiated");

      Get.snackbar("Success", "Video has been uploaded successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green);
      print("Success snackbar displayed");
    } catch (error, stackTrace) {
      // Handle errors
      print("Error creating video document: $error");
      Get.snackbar("Error", "Something went wrong try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("Error snackbar displayed");
    }
  }

  Future<void> createCourse(Course course, List combinedList) async {
    DocumentReference documentReference = await _db
        .collection("Courses")
        .add(course.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Course has been uploaded successfully",
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
    DocumentReference? contentDocRef;
    for (int i = 0; i < combinedList.length; i++) {
      if (combinedList[i]['type'] == "video") {
        String id = await uploadCourseVideo(
            combinedList[i]["content"], documentReference.id);
        await _db
            .collection("Courses")
            .doc(documentReference.id)
            .collection("CourseVideos")
            .add({"videoId": id});
        if (contentDocRef == null) {
          contentDocRef = await _db
              .collection("Courses")
              .doc(documentReference.id)
              .collection("CourseContent")
              .add({"${combinedList[i]["IDCOUNTER"]}": "video,${id}"});
        } else {
          await contentDocRef.set(
              {"${combinedList[i]["IDCOUNTER"]}": "video,${id}"},
              SetOptions(merge: true));
        }
      } else {
        String id = await uploadCourseQuiz(combinedList[i]["content"]);
        await _db
            .collection("Courses")
            .doc(documentReference.id)
            .collection("CourseQuiz")
            .add({"quizId": id});
        if (contentDocRef == null) {
          contentDocRef = await _db
              .collection("Courses")
              .doc(documentReference.id)
              .collection("CourseContent")
              .add({"${combinedList[i]["IDCOUNTER"]}": "quiz,${id}"});
        } else {
          await contentDocRef.set(
              {"${combinedList[i]["IDCOUNTER"]}": "quiz,${id}"},
              SetOptions(merge: true));
        }
      }
    }
    /*
    //List<dynamic> combinedList = [];
    int videoIndex = 0;
    int quizIndex = 0;
    int idCounter = 1;

    while (videoIndex < videoList.length || quizIndex < quizList.length) {
      //print(videoList[videoIndex]['index'].toString() == quizList[quizIndex]['quiz']['id'].toString());
      // If both video and quiz are available and have the same index
      if (videoIndex < videoList.length && quizIndex < quizList.length && videoList[videoIndex]['index'].toString() == quizList[quizIndex]['quiz']['id'].toString()) {
        print("If condition enterd");

        combinedList.add({"IDCOUNT":idCounter, "content" : videoList[videoIndex]});
        videoIndex++;
        idCounter++;
        print("\n\n\n\n---------------Adding Quiz to database------------\n\n\n\n");
        String id = await uploadCourseQuiz(quizList[quizIndex]);
        await _db.collection("Courses").doc(documentReference.id).collection("CourseQuiz").add({"quizId": id});
        await contentDocRef?.set({"${idCounter}": id}, SetOptions(merge: true));
        combinedList.add({"IDCOUNT":idCounter, "content" : quizList[quizIndex]});
        quizIndex++;
        idCounter++;
      }
      // If only video is available
      else if (videoIndex < videoList.length) {
        /*String id = await uploadCourseVideo(videoList[videoIndex]["file"], documentReference.id);
        await _db.collection("Courses").doc(documentReference.id).collection("CourseVideos").add({"videoId": id});
        if(contentDocRef == null){
          contentDocRef = await _db.collection("Courses").doc(documentReference.id).collection("CourseContent").add({"${idCounter}": id});
        }else{
          await contentDocRef.set({"${idCounter}": id}, SetOptions(merge: true));
        }*/
        combinedList.add({"IDCOUNT":idCounter, "content" : videoList[videoIndex]});
        videoIndex++;
        idCounter++;
      }
    }

    print("Combined List: $combinedList");*/
    /*List<Map<String, dynamic>> simplifiedList = [];

    int idCounter = 1;
    int videoIndex = 0;
    int quizIndex = 0;
    DocumentReference? contentDocRef;

    while (videoIndex < videoList.length || quizIndex < quizList.length) {
      if (videoIndex < videoList.length) {
        //String id = await uploadCourseVideo(videoList[videoIndex], documentReference.id);
        //await _db.collection("Courses").doc(documentReference.id).collection("CourseVideos").add({"videoId": id});
        //if(contentDocRef == null){
          //contentDocRef = await _db.collection("Courses").doc(documentReference.id).collection("CourseContent").add({"${idCounter}": id});
        //}else{
          //await contentDocRef.set({"${idCounter}": id}, SetOptions(merge: true));
        //}

        simplifiedList.add({'type': 'platformfile', 'index': idCounter++, 'video': videoList[videoIndex++]});

      }
      print("Length Val : ${quizList.length}");
      if (quizIndex < quizList.length) {
        print("Quiz Index : ${quizIndex}");
        print("\n\n ------------------- \nIn quiz ka If Condition \n ---------------------- \n\n");
        //String id = await uploadCourseQuiz(quizList[quizIndex]);
        //await _db.collection("Courses").doc(documentReference.id).collection("CourseQuiz").add({"quizId": id});
        //await _db.collection("Courses").doc(documentReference.id).collection("CourseContent").add({"${idCounter}": id});
        //await contentDocRef?.set({"${idCounter}": id}, SetOptions(merge: true));
        simplifiedList.add({'type': 'quiz', 'index': idCounter++, 'quizData': quizList[quizIndex]});
        quizIndex++;
      }
    }
    print("Everything successfully done");
    print(simplifiedList);*/
    /*List<String> idList = await uploadCourseVideo(videoList, documentReference.id);
    for (final id in idList) {
      print("Id Processing");
      await _db.collection("Courses").doc(documentReference.id).collection("CourseVideos").add({"videoId": id});
      print("Id Done");
    }

    List<String> quizIdList = await uploadCourseQuiz(quizList, documentReference.id);
    for (final id in idList) {
      print("Id Processing");
      await _db.collection("Courses").doc(documentReference.id).collection("CourseQuiz").add({"videoId": id});
      print("Id Done");
    }
    print("Khalaas");*/
  }

  Future<String> uploadCourseVideo(PlatformFile video, String? id) async {
    final duration = await getDuration(video);
    CourseVideo courseVideo =
        CourseVideo(videoTitle: video.name, videoLoc: "", duration: duration);
    DocumentReference documentReference =
        await _db.collection("VideoDetails").add(courseVideo.toJson());

    final uploadTask = FirebaseStorage.instance
        .ref()
        .child('videos/course${id}/${documentReference.id}.mp4');
    final metadata = SettableMetadata(contentType: 'video/mp4');
    final TaskSnapshot snapshot =
        await uploadTask.putFile(File(video.path!), metadata);
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> updateData = {'videoLoc': downloadUrl};
    await _db
        .collection("VideoDetails")
        .doc(documentReference.id)
        .update(updateData);

    return documentReference.id;
  }

  Future<String> uploadCourseQuiz(Map<String, dynamic> quizMap) async {
    print(
        "\n\n ------------------- \nIn quiz ka Upload Function \n ---------------------- \n\n");
    Map<String, dynamic>? quizData = quizMap['quiz'];
    print(
        "\n\n ------------------- \nMap Initialize Kiya ${quizMap} \n ---------------------- \n\n");
    Quiz quiz = Quiz(
        question: quizMap["question"],
        options: quizMap["options"],
        correctOption: quizMap["correctAnswer"]);
    print(
        "\n\n ------------------- \nQuiz ka object Banaya\n ---------------------- \n\n");
    DocumentReference documentReference =
        await _db.collection("Quiz").add(quiz.toJson());
    print(
        "\n\n ------------------- \nDocument in quiz created\n ---------------------- \n\n");
    return documentReference.id;
  }

  Future<String> getDuration(PlatformFile file) async {
    final controller = VideoPlayerController.file(File(file.path!));
    await controller.initialize();
    final duration = controller.value.duration;
    controller.dispose();
    return duration.toString();
  }

  Future<Iterable<Video>> getVideoList(String query) async {
    print("Inside Repository");
    final columns = ["instructorId", "instructorName", "subject", "videoTitle"];
    final snapshot = await _db
        .collection("VideoDetails")
        .where(columns[0], isEqualTo: query)
        .where(columns[1], isEqualTo: query)
        .where(columns[2], isEqualTo: query)
        .where(columns[3], isEqualTo: query)
        .get();

    final videoList = snapshot.docs.map((e) => Video.fromSnapshot(e));
    print(videoList.length);
    return videoList;
  }

  Future<Iterable<Video>> fetchData(String query) async {
    final columns = ["instructorId", "instructorName", "subject", "videoTitle"];

    // Create a Firestore query for each field
    Query query = FirebaseFirestore.instance.collection('VideoDetails');
    for (String field in columns) {
      query = query.where(
        field,
        isEqualTo: query,
      );
    }

    // Execute the query
    QuerySnapshot querySnapshot = await query.get();

    // Process the query results
    final videoList = querySnapshot.docs.map(
        (e) => Video.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>));
    print(videoList.length);
    return videoList;
  }
}
