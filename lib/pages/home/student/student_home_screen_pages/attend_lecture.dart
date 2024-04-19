import 'package:final_project/controllers/profile_controller.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/search_screen.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:googleapis/spanner/v1.dart';
import 'package:video_player/video_player.dart';

import '../../../../controllers/teacher_profile_controller.dart';
import '../../../../models/backend_model.dart';
import '../../../common/video/video_viewer.dart';

class AttendLecture extends ConsumerStatefulWidget {
  final Video video;
  const AttendLecture({super.key, required this.video});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttendLectureState();
}

class _AttendLectureState extends ConsumerState<AttendLecture> {
  @override
  Widget build(BuildContext context) {
    final instructorController = Get.put(TeacherProfileController());
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayerView(
                      url: widget.video.videoLoc,
                      dataSourceType: DataSourceType.network,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralAppText(
                        text: widget.video.videoTitle,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      GeneralAppText(
                        text: widget.video.subject,
                        size: 15,
                        weight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralAppText(
                        text: "Duration",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      GeneralAppText(
                        text: widget.video.duration,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralAppText(
                        text: "Description",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GeneralAppText(
                        text: widget.video.videoDescription,
                        //"The Merchant of Venice is a 16th-century play written by William Shakespeare in which a merchant in Venice named Antonio defaults on a large loan provided by a Jewish moneylender, Shylock. It is believed to have been written between 1596 and 1599.",
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 55, 55, 55),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 400,
                              width: double.infinity,
                              child: FutureBuilder<Map<String, dynamic>>(
                                future: instructorController.getInstructorDetailsToDisplay(widget.video.instructorId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Display a loading indicator while waiting for data
                                  } else if (snapshot.hasError) {
                                    print(widget.video.instructorId);
                                    return Text('Error: ${snapshot.error}'); // Display an error message if fetching data fails
                                  } else {
                                    final instructorDetails = snapshot.data;
                                    if (instructorDetails != null) {
                                      final image = instructorDetails["image"];
                                      final name = instructorDetails["name"];
                                      final orgName =
                                          instructorDetails["orgName"];
                                      final videoImageList =
                                          instructorDetails["videoImageList"];
                                      final id = instructorDetails["id"];
                                      Visit visit =
                                          instructorDetails["visitData"];
                                      print(
                                          "Instructor ke Visit Details : ${visit}");

                                      // Build your UI using the fetched data
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                    image: NetworkImage(image),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GeneralAppText(
                                                    text: name,
                                                    size: 18,
                                                    weight: FontWeight.bold,
                                                  ),
                                                  GeneralAppText(
                                                    text: orgName,
                                                    size: 14,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          GeneralAppText(
                                            text: "Other Lectures by $name",
                                            size: 16,
                                            weight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {
                                              /*Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const SearchScreen()));*/
                                            },
                                            child: SizedBox(
                                              height: 100,
                                              width: double.infinity,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    videoImageList.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    height: 100,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: MemoryImage(
                                                            videoImageList[
                                                                index]),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          GeneralAppText(
                                            text: "Upcoming Visits",
                                            size: 16,
                                            weight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            height: 70,
                                            width: double.infinity,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Visit Date & Time : ${visit.visitDate} ${visit.visitTime} \nVisit Location : ${visit.visitLocation} \nVisit Purpose : ${visit.visitPurpose} ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(width: 10),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                          'No data available'); // Handle case where data is null
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildTextColumn(String title, String value) {
    return Flexible(
      // Wrap the Column with Flexible
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
