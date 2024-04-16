import 'package:final_project/pages/common/books/ebooks_screen.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/check_assignments.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/home_screen.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/profile_screen.dart';
import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/teacher_stats.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherScreen extends ConsumerStatefulWidget {
  const TeacherScreen({super.key});

  @override
  ConsumerState<TeacherScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends ConsumerState<TeacherScreen> {
  int _currentIndex = 0;
  final List<Widget> body = const [
    TeacherHomeScreen(),
    EbooksScreen(),
    CheckAssignments(),
    TeacherProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final theme = ref.read(settingsProvider.notifier).isLightMode;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 26,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            tooltip: "Home",
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: GeneralAppIcon(
                  icon: Icons.home_rounded,
                  color: theme ? Colors.white : Colors.white),
            ),
            icon: const Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            tooltip: "Search",
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: GeneralAppIcon(
                  icon: Icons.search_rounded,
                  color: theme ? Colors.white : Colors.white),
            ),
            icon: const Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            tooltip: "Check Assignments",
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: GeneralAppIcon(
                  icon: Icons.check_box_rounded,
                  color: theme ? Colors.white : Colors.white),
            ),
            icon: const Icon(Icons.check_box_rounded),
            label: 'Check Assignments',
          ),
          BottomNavigationBarItem(
            tooltip: "Profile",
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: GeneralAppIcon(
                  icon: Icons.person,
                  color: theme ? Colors.white : Colors.white),
            ),
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
