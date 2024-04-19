import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:final_project/repository/video_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/backend_model.dart';

class VideoController extends GetxController {
  static VideoController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  final _videoRepo = Get.put(VideoRepository());

  createVideoDetail(Video video, PlatformFile lectureVideo, [File? img]) {
    _videoRepo.createVideoDocument(video, lectureVideo, img);
  }

  createCourse(Course course, List combinedList) {
    _videoRepo.createCourse(course, combinedList);
  }

  getVideos(String subject) {
    print("Inside Controller");
    //_videoRepo.getVideoList(subject);
    _videoRepo.fetchData(subject);
  }

  getContentBySearch(String subject, String query){
      return _videoRepo.getContentBySearch(subject, query);
  }
  getSearchContentBySearch(bool video, String category, String duration, String query){
    if(query != ""){
      return _videoRepo.getSearchContentBySearch(video, category, duration, query);
    }else{
      return "Please Enter a search query";
    }
  }

}
