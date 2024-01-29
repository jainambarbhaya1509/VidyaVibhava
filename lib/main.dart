import 'package:final_project/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:final_project/pages/home/student_home_screen.dart';
import 'package:final_project/pages/home/teacher_home_screen.dart';
import 'package:final_project/pages/logins/student_login_screen.dart';
import 'package:final_project/pages/logins/teacher_login_screen.dart';
import 'package:final_project/pages/common/otp_screen.dart';
import 'package:final_project/pages/signups/student_sign_up_screen.dart';
import 'package:final_project/pages/signups/teacher_sign_up_screen.dart';
import 'package:final_project/pages/common/start_screen.dart';
import 'package:final_project/pages/common/user_type_screen.dart';
import 'package:final_project/style/themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(
    ProviderScope(
      child: MyApp(
        showHome: showHome,
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appBarProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Education',
      theme: theme.isLightMode == true ? lightTheme : darkTheme,
      home: showHome ? const UserTypeScreen() : const StartScreen(),
      routes: {
        'onboardingScreen': (context) => const StartScreen(),
        'usersTypeScreen': (context) => const UserTypeScreen(),
        'studentLogin': (context) => const StudentLoginScreen(),
        'studentSignUp': (context) => const StudentSignUpScreen(),
        'teacherLogin': (context) => const TeacherLoginScreen(),
        'teacherSignUp': (context) => const TeacherSignUpScreen(),
        'getOTP': (context) => const OTPScreen(),
        'studentHome': (context) => const StudentHomeScreen(),
        'teacherHome': (context) => const TeacherHomeScreen(),
      },
    );
  }
}
