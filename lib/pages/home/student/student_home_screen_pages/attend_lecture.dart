import 'package:final_project/providers/lecture_data_provider.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendLecture extends ConsumerStatefulWidget {
  final int lectureIndex;
  AttendLecture({
    super.key,
    required this.lectureIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttendLectureState();
}

class _AttendLectureState extends ConsumerState<AttendLecture> {
  @override
  Widget build(BuildContext context) {
    final lectureVideo = ref.read(lectureDataProvider);
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
                    Container(
                      height: 200,
                      width: double.infinity,
                      // color: Colors.amber,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GeneralAppIcon(
                          icon: Icons.replay_10,
                          color: Colors.grey[100] ?? Colors.grey,
                          size: 40,
                        ),
                        GeneralAppIcon(
                          icon: Icons.play_arrow,
                          color: Colors.grey[100] ?? Colors.grey,
                          size: 40,
                        ),
                        GeneralAppIcon(
                          icon: Icons.forward_10_outlined,
                          color: Colors.grey[100] ?? Colors.grey,
                          size: 40,
                        ),
                      ],
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
                        text: lectureVideo.lectures[widget.lectureIndex].title,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      GeneralAppText(
                        text: "William Shakespeare",
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
                        text: "1 Hour",
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
                        text:
                            "The Merchant of Venice is a 16th-century play written by William Shakespeare in which a merchant in Venice named Antonio defaults on a large loan provided by a Jewish moneylender, Shylock. It is believed to have been written between 1596 and 1599.",
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 55, 55, 55),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 400,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GeneralAppText(
                                          text: "Mr. John Doe",
                                          size: 18,
                                          weight: FontWeight.bold,
                                        ),
                                        GeneralAppText(
                                          text: "Instructional Designer",
                                          size: 14,
                                          weight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                // other lectures by
                                GeneralAppText(
                                  text: "Other Lectures by Mr. John Doe",
                                  size: 16,
                                  weight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 100,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        height: 100,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // upcoming visits
                                const SizedBox(
                                  height: 20,
                                ),
                                GeneralAppText(
                                  text: "Upcoming Visits",
                                  size: 16,
                                  weight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 70,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        height: 100,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
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
}
