
import 'dart:io';
import 'dart:typed_data';

import 'package:final_project/controllers/video_controller.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/enrolled_courses.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:final_project/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controllers/profile_controller.dart';
import '../../../../models/backend_model.dart';
final filterDialogStateProvider = StateProvider.autoDispose((ref) {
  return FilterDialogState();
});
class FilterDialogState {
  late bool videoSelected = true;
  late String searchBy = "instructorName";
  late String duration = "";
}
class SearchScreen extends ConsumerStatefulWidget {
  final String? instructorName;
  const SearchScreen({super.key, this.instructorName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}
//late final filterDialogState;
class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchQuery = TextEditingController();
  final controller = Get.put(VideoController());
  final profileController = Get.put(ProfileController());
  List<dynamic> result = [];
  late bool ans;
  late Video video;
  late Course course;
  late String title, description, instructorName;
  late Uint8List image;
  Future<void> _performSearch(bool videoSelected, String searchBy, String duration) async {

    List<dynamic> queryResultList = await controller.getSearchContentBySearch(videoSelected, searchBy, duration, searchQuery.text);
    setState(() {
      result = queryResultList;
      ans = videoSelected;
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    final filterDialogState = ref.watch(filterDialogStateProvider);
    final bool videoSelected = filterDialogState.videoSelected;
    final String searchBy = filterDialogState.searchBy;
    final String duration = filterDialogState.duration;
    bool isCourse = false;
    TextEditingController toDisplayText = TextEditingController();
    if (widget.instructorName != null) {
      searchQuery.text = (widget.instructorName)!;
    }
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: GeneralAppText(
              text: "Search",
              size: 23,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.isLightMode
                  ? const Color.fromARGB(211, 228, 228, 228)
                  : const Color.fromARGB(255, 54, 54, 54),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: searchQuery,
              decoration: InputDecoration(
                hintText: "search a video/course",
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () {
                    _showFilterDialog(context);
                  },
                  child: GeneralAppIcon(
                      icon: Icons.filter_alt_sharp, color: Colors.grey),
                ),
                prefixIcon: GestureDetector(
                    onTap: () {
                      print("Search Clicked");
                      _performSearch(videoSelected,searchBy, duration);
                    },
                    child: const Icon(Icons.search)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                if(ans){
                  video = result[index];
                  title = video.videoTitle;
                  description = video.videoDescription;
                  instructorName = video.instructorName;
                  image = video.thumbnailImage;
                  toDisplayText.text = "Start Learning";
                }
                else{
                  course = result[index];
                  title = course.courseTitle;
                  description = course.courseDescription;
                  instructorName = course.instructorName;
                  image = course.thumbnailImage;
                  toDisplayText.text = "Enroll Now";
                  setState(() {
                    isCourse = true;
                  });
                }
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (builder) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 5,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 190,
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child : Image.memory(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: theme == true
                                                    ? textColor1
                                                    : textColor2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: GeneralAppIcon(
                                          icon: Icons.bookmark_border,
                                          color: theme == true
                                              ? textColor1
                                              : textColor2,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: theme == true
                                                    ? textColor1
                                                    : textColor2),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap:(){
                                                  if(isCourse){
                                                    EnrolledCourse enrolledCourse = EnrolledCourse(courseId: course.courseId!, lastCompleted: "", isCompleted: false, noOfVideosWatched: 0, quizScore: 0);
                                                    profileController.enrollCourse(enrolledCourse);
                                                    Navigator.push(context, _createAnimatedScreenRoute(const EnrolledCourses(), 1, 0));
                                                  }
                                                },
                                                child: GeneralAppIcon(
                                                  icon: Icons.play_arrow_rounded,
                                                  color: theme == true
                                                      ? textColor1
                                                      : textColor2,
                                                  size: 30,
                                                ),
                                              ),
                                              PrimaryAppText(
                                                text: toDisplayText.text,
                                                size: 20,
                                                color: theme == true
                                                    ? textColor1
                                                    : textColor2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: GeneralAppText(
                                            text: title,
                                            size: 20,
                                            weight: FontWeight.bold,
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: GeneralAppText(
                                            text: "Description",
                                            size: 20,
                                            weight: FontWeight.bold,
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GeneralAppText(
                                        text: description,
                                        size: 15,
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.memory(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GeneralAppText(
                                text: title,
                                size: 16,
                                weight: FontWeight.bold,
                                color:
                                    theme.isLightMode ? textColor1 : textColor2,
                              ),
                              GeneralAppText(
                                text: instructorName,
                                size: 15,
                                color:
                                    theme.isLightMode ? textColor1 : textColor2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog();
      },
    );
  }

  Route _createAnimatedScreenRoute(
      Widget child, double startOffset, double endOffset) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(startOffset, endOffset);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
