import 'package:final_project/pages/common/books/ebooks_screen.dart';
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
    TeacherStatsScreen(),
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
            
            activeIcon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GeneralAppIcon(
                  icon: Icons.home_rounded,
                  color: theme ? primaryColor : Colors.white),
            ),
            icon: const Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GeneralAppIcon(
                  icon: Icons.search,
                  color: theme ? primaryColor : Colors.white),
            ),
            icon: const Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GeneralAppIcon(
                  icon: Icons.analytics_rounded,
                  color: theme ? primaryColor : Colors.white),
            ),
            icon: const Icon(Icons.analytics_rounded),
            label: 'Analyze',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GeneralAppIcon(
                  icon: Icons.person,
                  color: theme ? primaryColor : Colors.white),
            ),
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
