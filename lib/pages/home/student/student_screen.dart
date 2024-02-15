
import 'package:final_project/pages/home/student/student_home_screen_pages/ebooks_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/news_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/profile_screen.dart';
import 'package:final_project/style/themes.dart';
import 'package:flutter/material.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> body = [
    const HomeScreen(),
    const NewsScreen(),
    const EbooksScreen(),
    const ProfileScreen(),
  ];

  List<IconData> iconList = [
    Icons.home_outlined,
    Icons.newspaper_rounded,
    Icons.menu_book_sharp,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      body: body[_currentIndex],
      
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(100),
        ),
        child: ListView.builder(
          itemCount: body.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(
                    bottom: index == _currentIndex ? 0 : size.width * .029,
                    right: size.width * .0422,
                    left: size.width * .0422,
                  ),
                  width: size.width * .128,
                  height: index == _currentIndex ? size.width * .012 : 0,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Icon(
                  iconList[index],
                  size: size.width * .07,
                  color: index == _currentIndex ? primaryColor : Colors.grey,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
