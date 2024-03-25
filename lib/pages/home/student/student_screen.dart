import 'package:final_project/pages/common/books/ebooks_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/community_screen.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/profile_screen.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentScreen extends ConsumerStatefulWidget {
  const StudentScreen({super.key});

  @override
  ConsumerState<StudentScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends ConsumerState<StudentScreen> {
  int _currentIndex = 0;

  final List<Widget> body = [
    const StudentHomeScreen(),
    const CommunityScreen(),
    const EbooksScreen(),
    const StudentProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier).isLightMode;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
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
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: GeneralAppIcon(
                  icon: Icons.group_rounded,
                  color: theme ? Colors.white : Colors.white),
            ),
            icon: const Icon(Icons.group_rounded),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: GeneralAppIcon(
                  icon: Icons.menu_book_sharp,
                  color: theme ? Colors.white : Colors.white),
            ),
            icon: const Icon(Icons.menu_book_sharp),
            label: 'EBooks',
          ),
          BottomNavigationBarItem(
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
