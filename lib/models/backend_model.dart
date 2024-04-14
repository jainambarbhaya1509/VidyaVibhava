import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  late String? uid;
  final String firstName,
      lastName,
      dateOfBirth,
      gender,
      phoneNo,
      username,
      address,
      zipCode,
      city,
      state;
  late final String image, doc1, doc2;
  late String deviceToken;

  Student({
    this.uid,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNo,
    required this.username,
    required this.address,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.image,
    required this.doc1,
    required this.doc2,
    required this.deviceToken,
  });

  toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phoneNo': phoneNo,
      'username': username,
      'address': address,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'image': image,
      'doc1': doc1,
      'doc2': doc2,
      'deviceToken': deviceToken,
    };
  }

  factory Student.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Student(
      uid: data['uid'],
      firstName: data["firstName"],
      lastName: data["lastName"],
      dateOfBirth: data["dateOfBirth"],
      gender: data["gender"],
      phoneNo: data["phoneNo"],
      username: data["username"],
      address: data["address"],
      zipCode: data["zipCode"],
      city: data["city"],
      state: data["state"],
      image: data["image"],
      doc1: data["doc1"],
      doc2: data["doc2"],
      deviceToken: data["deviceToken"],
    );
  }
}

class Teacher {
  late String? uid;
  final String firstName,
      lastName,
      dateOfBirth,
      gender,
      phoneNo,
      username,
      email,
      address,
      zipCode,
      city,
      state,
      organizationName,
      image,
      doc1,
      doc2;
  final bool cddaAffiliation, isMentor;
  final List<String> subjectPreference;
  late final String deviceToken;

  Teacher({
    this.uid,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNo,
    required this.username,
    required this.email,
    required this.address,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.organizationName,
    required this.cddaAffiliation,
    required this.subjectPreference,
    required this.isMentor,
    required this.image,
    required this.doc1,
    required this.doc2,
  });

  toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phoneNo': phoneNo,
      'username': username,
      'email': email,
      'address': address,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'organizationName': organizationName,
      'cddaAffiliation': cddaAffiliation,
      'subjectPrefernce': subjectPreference,
      'isMentor': isMentor,
      'image': image,
      'doc1': doc1,
      'doc2': doc2,
      'deviceToken': deviceToken,
    };
  }

  factory Teacher.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final subjectPreferenceDynamic = data["subjectPreference"];
    List<String> subjectPreference = (subjectPreferenceDynamic is List)
        ? List<String>.from(subjectPreferenceDynamic)
        : [];
    return Teacher(
      uid: document.id,
      firstName: data["firstName"] ?? "",
      lastName: data["lastName"] ?? "",
      dateOfBirth: data["dateOfBirth"] ?? "",
      gender: data["gender"] ?? "",
      phoneNo: data["phoneNo"] ?? "",
      username: data["username"] ?? "",
      email: data["email"] ?? "",
      address: data["address"] ?? "",
      zipCode: data["zipCode"] ?? "",
      city: data["city"] ?? "",
      organizationName: data["organiationName"] ?? "",
      state: data["state"] ?? "",
      subjectPreference: subjectPreference,
      cddaAffiliation: data["cddaAffiliation"] ?? "",
      image: data["image"] ?? "",
      isMentor: data["isMentor"] ?? "",
      doc2: data["doc2"] ?? "",
      doc1: data["doc1"] ?? "",
    );
  }
}

class Video {
  late String? videoId;
  final String videoTitle,
      videoDescription,
      videoLoc,
      difficultyLevel,
      duration,
      subject,
      instructorName,
      thumbnail,
      instructorId;
  late Uint8List thumbnailImage;
  final List<String> keywords;

  Video({
    this.videoId,
    required this.videoTitle,
    required this.videoDescription,
    required this.videoLoc,
    required this.keywords,
    required this.difficultyLevel,
    required this.duration,
    required this.subject,
    required this.instructorName,
    required this.thumbnail,
    required this.instructorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'videoTitle': videoTitle,
      'videoDescription': videoDescription,
      'videoLoc': videoLoc,
      'keywords': keywords,
      'difficultyLevel': difficultyLevel,
      'duration': duration,
      'subject': subject,
      'instructorName': instructorName,
      'thumbnail': thumbnail,
      'instructorId': instructorId,
    };
  }

  factory Video.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Video(
      videoId: document.id ?? "",
      videoTitle: data["videoTitle"] ?? "",
      videoDescription: data["videoDescription"] ?? "",
      videoLoc: data["videoLoc"] ?? "",
      keywords: List<String>.from(data["keywords"]) ?? [],
      difficultyLevel: data["difficultyLevel"] ?? "",
      duration: data["duration"] ?? "",
      subject: data["subject"] ?? "",
      instructorName: data["instructorName"] ?? "",
      thumbnail: data["thumbnail"] ?? "",
      instructorId: data["instructorId"] ?? "",
    );
  }
}

class CourseVideo {
  late String? videoId;
  final String videoTitle, duration;
  late String videoLoc;

  CourseVideo({
    this.videoId,
    required this.videoTitle,
    required this.videoLoc,
    required this.duration,
  });

  // Method to convert CourseVideo object to a map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'videoTitle': videoTitle,
      'videoLoc': videoLoc,
      'duration': duration,
    };
  }

  // Factory method to create CourseVideo object from a Firestore document snapshot
  factory CourseVideo.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return CourseVideo(
      videoId: document.id,
      videoTitle: data["videoTitle"],
      videoLoc: data["videoLoc"],
      duration: data["duration"],
    );
  }

  // Method to create a CourseVideo object from a map
  factory CourseVideo.fromMap(Map<String, dynamic> map) {
    return CourseVideo(
      videoId: map['videoId'],
      videoTitle: map['videoTitle'],
      videoLoc: map['videoLoc'],
      duration: map['duration'],
    );
  }
}

class Course {
  late String? courseId;
  final String courseTitle,
      courseDescription,
      courseLoc,
      difficultyLevel,
      duration,
      subject,
      instructorName,
      thumbnail,
      instructorId;
  late Uint8List thumbnailImage;
  final List<String> keywords;

  Course({
    this.courseId,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseLoc,
    required this.keywords,
    required this.difficultyLevel,
    required this.duration,
    required this.subject,
    required this.instructorName,
    required this.thumbnail,
    required this.instructorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'courseTitle': courseTitle,
      'courseDescription': courseDescription,
      'courseLoc': courseLoc,
      'keywords': keywords,
      'difficultyLevel': difficultyLevel,
      'duration': duration,
      'subject': subject,
      'instructorName': instructorName,
      'thumbnail': thumbnail,
      'instructorId': instructorId,
    };
  }

  factory Course.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Course(
      courseId: document.id,
      courseTitle: data["courseTitle"],
      courseDescription: data["courseDescription"],
      courseLoc: data["courseLoc"],
      keywords: List<String>.from(data["keywords"]),
      difficultyLevel: data["difficultyLevel"],
      duration: data["duration"],
      subject: data["subject"],
      instructorName: data["instructorName"],
      thumbnail: data["thumbnail"],
      instructorId: data["instructorId"],
      //courseVideos: (data['CourseVideos'] as List<Map<String, dynamic>>).map((videoData) => CourseVideo.fromMap(videoData)).toList(),
    );
  }
}

class Assignment {}

class Quiz {
  late String? quizId;
  final int index;
  final List<dynamic> options;
  final String correctOption;

  Quiz(
      {this.quizId,
      required this.index,
      required this.options,
      required this.correctOption});
  Map<String, dynamic> toJson() {
    return {
      'courseId': quizId,
      'index': index,
      'options': options,
      'correctOption': correctOption,
    };
  }

  factory Quiz.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Quiz(
      quizId: document.id,
      index: data["index"],
      options: List<String>.from(data["options"]),
      correctOption: data["correctOption"],
    );
  }
}

class Message {
  final String senderId, senderEmail, receiverId, message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}

class Visit {
  late String? visitId;
  late String visitMentorId;
  final String visitDate;
  final String visitTime;
  final String visitLocation;
  final String visitPurpose;
  final String visitDescription;

  Visit({
    this.visitId,
    required this.visitMentorId,
    required this.visitDate,
    required this.visitTime,
    required this.visitLocation,
    required this.visitPurpose,
    required this.visitDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'visitId': visitId,
      'visitMentorId': visitMentorId,
      'visitDateAndTime': visitDate,
      'visitTime': visitTime,
      'visitLocation': visitLocation,
      'visitPurpose': visitPurpose,
      'visitDescription': visitDescription,
    };
  }

  factory Visit.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Visit(
      visitId: document.id ?? "",
      visitMentorId: data["visitMentorId"] ?? "",
      visitDate: data["visitDate"] ?? "",
      visitTime: data["visitTime"] ?? "",
      visitLocation: data["visitLocation"] ?? "",
      visitPurpose: data["visitPurpose"] ?? "",
      visitDescription: data["visitDescription"] ?? "",
    );
  }
}
