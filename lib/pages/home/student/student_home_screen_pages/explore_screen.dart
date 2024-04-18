import 'package:final_project/pages/common/books/ebooks_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/community_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/enrolled_courses.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/explore_schemes.dart';
import 'package:final_project/pages/home/student/cards/saved_books_card.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/jobs_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/saved_books.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/saved_videos.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/search_textbooks.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExploreScreenState();
}

final List<IconData> navigationIcons = [
  Icons.groups_3_sharp,
  Icons.menu_book_rounded,
  Icons.local_library_rounded,
  Icons.insights_outlined,
  Icons.video_collection_outlined,
  Icons.play_circle_filled_outlined,
  Icons.bookmark_border_rounded,
  Icons.work_rounded
];
final List<String> navigationText = [
  "Community",
  "Text Books",
  "Library",
  "Schemes",
  "Enrolled Courses",
  "Saved Videos",
  "Saved Books",
  "Search Jobs"
];
final List<String> navigationDesciption = [
  "Join a community of learners",
  "Start learning with text books",
  "Find your relevent ebooks",
  "Explore government initiatives for you",
  "Continue learning with your enrolled courses",
  "Watch your saved videos",
  "Read your saved books",
  "Find your jobs"
];
final List<ConsumerStatefulWidget> navigationPath = [
  const CommunityScreen(),
  const SearchTextBooks(),
  const EbooksScreen(),
  const ExploreSchemes(),
  const EnrolledCourses(),
  const SavedVideos(),
  const SavedBooks(),
  const JobsScreen(),
];

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: GeneralAppText(
            text: 'Explore',
            size: 20,
            weight: FontWeight.bold,
            color: theme.isLightMode ? textColor1 : textColor2,
          )),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GridView.builder(
            itemCount: navigationIcons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 3,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.isLightMode
                        ? const Color.fromARGB(211, 228, 228, 228)
                        : const Color.fromARGB(255, 54, 54, 54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralAppIcon(
                        icon: navigationIcons[index],
                        color: Colors.grey,
                        size: 35,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.lightBlueAccent,
                            child: GeneralAppText(
                              text: navigationText[index],
                              size: 20,
                              weight: FontWeight.bold,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                            ),
                          ),
                          Container(
                            // color: Colors.lightGreen,
                            width: double.infinity,
                            child: GeneralAppText(
                              text: navigationDesciption[index],
                              size: 15,
                              weight: FontWeight.normal,
                              color:
                                  theme.isLightMode ? textColor1 : textColor2,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => navigationPath[index]));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          child: GeneralAppIcon(
                            icon: Icons.arrow_right_alt_rounded,
                            color: primaryColor,
                            size: 35,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
