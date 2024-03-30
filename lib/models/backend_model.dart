import 'package:cloud_firestore/cloud_firestore.dart';

class Student{
  late String? uid;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String phoneNo;
  final String username;
  final String address;
  final String zipCode;
  final String city;
  final String state;
  late final String image;
  late final String doc1 ;
  late final String doc2 ;

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
  });

  toJson(){
    return{
      'uid':uid,
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
    };
  }

  factory Student.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Student(
      uid: document.id,
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
    );
  }
}

class ContinueWatching{}
class EnrolledCourse{}
class Course{}
class Teacher{}
class Mentor {
  late String mentorId;
  final String mentorName;

  Mentor({
    required this.mentorId,
    required this.mentorName,
  });

  factory Mentor.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Mentor(
      mentorId: document.id,
      mentorName: data["mentorName"],
    );
  }

  toJson() {
    return {
      'mentorId': mentorId,
      'mentorName': mentorName,
    };
  }
}

class Textbook{}

class Video {
  late String? videoId;
  final String videoTitle;
  final String videoDescription;
  late String videoLoc;
  final List<String> keywords;
  final String difficultyLevel;
  final String duration;
  final String subject;
  final String instructorName;
  final String thumbnail;

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
      'thumbnail':thumbnail,
    };
  }

  factory Video.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Video(
      videoId: document.id,
      videoTitle: data["videoTitle"],
      videoDescription: data["videoDescription"],
      videoLoc: data["videoLoc"],
      keywords: List<String>.from(data["keywords"]),
      difficultyLevel: data["difficultyLevel"],
      duration: data["duration"],
      subject: data["subject"],
      instructorName: data["instructorName"],
      thumbnail: data["thumbnail"],
    );
  }
}

class Assignment{}

class Message{
  final String senderId, senderEmail, receiverId, message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.message,
  });

  Map<String, dynamic> toMap(){
    return{
      'senderId' : senderId,
      'senderEmail':senderEmail,
      'receiverId':receiverId,
      'message':message,
      'timestamp':timestamp,
    };
  }
}