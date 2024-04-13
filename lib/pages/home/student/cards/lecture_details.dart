import 'package:final_project/models/backend_model.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/attend_lecture.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final savedLecturesProvidrer = Provider((ref) => []);

class LectureDetails extends ConsumerStatefulWidget {
  final Video video;

  const LectureDetails({Key? key, required this.video}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LectureDetailsState();
}


class _LectureDetailsState extends ConsumerState<LectureDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier).isLightMode;
    final videoToDisplay = widget.video;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                            onTap: () {},
                            child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                          theme == true ? textColor1 : textColor2),
                              borderRadius: BorderRadius.circular(10)),
                          child: GeneralAppIcon(
                            icon: Icons.bookmark_border,
                            color: theme == true ? textColor1 : textColor2,
                            size: 30,
                              ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AttendLecture(video: videoToDisplay)));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: theme == true ? textColor1 : textColor2),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GeneralAppIcon(
                                  icon: Icons.play_arrow_rounded,
                                  color: theme == true ? textColor1 : textColor2,
                                  size: 30,
                                ),
                                PrimaryAppText(
                                  text: "Start Learning",
                                  size: 20,
                                  color: theme == true ? textColor1 : textColor2,
                                ),
                              ],
                            ),
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
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Column(
                    children: [
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
                        text:widget.video.videoDescription,
                            //"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia. Nullam nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia.",
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
