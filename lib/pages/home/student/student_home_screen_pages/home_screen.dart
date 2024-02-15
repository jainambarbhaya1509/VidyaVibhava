import 'package:final_project/models/models.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Subject> subjects = [
    Subject(name: "Language", imageUrl: 'assets/img/lang.png'),
    Subject(name: "Maths", imageUrl: 'assets/img/maths.png'),
    Subject(name: "Physics", imageUrl: 'assets/img/phy.png'),
    Subject(name: "Chemistry", imageUrl: 'assets/img/chem.png'),
    Subject(name: "History", imageUrl: 'assets/img/hist.png'),
    Subject(name: "Geography", imageUrl: 'assets/img/geo.png'),
    Subject(name: "Biology", imageUrl: 'assets/img/bio.png'),

    // Add more subjects here if needed
  ];
  @override
  Widget build(BuildContext context) {
    final theme = ref.read(settingsProvider.notifier).isLightMode;
    return Scaffold(
      
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: GeneralAppText(
                    text: "jainambarbhaya",
                    size: 20,
                  ),
                ),
                Row(
                  children: [
                    GeneralAppIcon(color: primaryColor, icon: Icons.rocket_launch,),
                    const SizedBox(width: 30,),
                    GestureDetector(
                      onTap: () {},
                      child: GeneralAppIcon(
                        icon: Icons.chat_bubble_outline,
                        color: theme == true ? textColor1 : textColor2,
                        size: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),


      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        // color: Colors.white,
        padding: const EdgeInsets.only(top: 20),

        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Latest News
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralAppText(
                  text: "What's Latest?",
                  size: 20,
                  weight: FontWeight.bold,
                ),
                GeneralAppIcon(
                  icon: Icons.navigate_next_sharp,
                  color: primaryColor,
                  size: 30,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
            ),
            const SizedBox(
              height: 30,
            ),

            // Explore subjects
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GeneralAppText(
                    text: "Explore Subjects ",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                ),
                GeneralAppIcon(
                  icon: Icons.navigate_next_sharp,
                  color: primaryColor,
                  size: 30,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.23,
              child: ListView.builder(
              
                scrollDirection: Axis.horizontal,
                itemCount: subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            color: theme == true ? textColor1 : textColor2,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image(
                            fit: BoxFit.scaleDown,
                            image:
                                AssetImage(subjects[index].imageUrl,),
                          ),
                        ),
                      ),
                      GeneralAppText(
                        text: subjects[index].name,
                        color: primaryColor,
                        size: 13,
                      )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 30,),
            // continue learning
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralAppText(
                  text: "Continue Learning",
                  size: 20,
                  weight: FontWeight.bold,
                ),
                GeneralAppIcon(
                  icon: Icons.navigate_next_sharp,
                  color: primaryColor,
                  size: 30,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
