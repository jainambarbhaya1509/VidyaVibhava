import 'package:final_project/pages/common/chat/chat_list.dart';
import 'package:final_project/pages/common/gemini.dart';
import 'package:final_project/pages/home/student/career_quiz/career_quiz.dart';
import 'package:final_project/pages/home/student/career_quiz/career_quiz_result.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/jobs_screen.dart';
import 'package:final_project/pages/home/student/student_screen.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/repository/user_repository.dart';
import 'package:final_project/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_project/pages/home/teacher/teacher_screen.dart';
import 'package:final_project/pages/logins/student_login_screen.dart';
import 'package:final_project/pages/logins/teacher_login_screen.dart';
import 'package:final_project/pages/common/otp_screen.dart';
import 'package:final_project/pages/signups/student_sign_up_screen.dart';
import 'package:final_project/pages/signups/teacher_sign_up_screen.dart';
import 'package:final_project/pages/common/start_screen.dart';
import 'package:final_project/pages/common/user_type_screen.dart';
import 'package:final_project/style/themes.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize AuthenticationRepository and register it with GetX
  final authenticationRepository = AuthenticationRepository();
  final userRepository = UserRepository();
  Get.put(authenticationRepository);
  Get.put(userRepository);
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  //final notificationService = NotificationService(); // Add this line
  //await notificationService.init();
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
    Logger().d(MediaQuery.of(context).size);

    final theme = ref.watch(settingsProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Education',
      theme: theme.isLightMode == true ? lightTheme : darkTheme,
      // home: showHome ? const UserTypeScreen() : const StartScreen(),
      home: const TeacherScreen(),
      // home: const CareerQuiz(),
      routes: {
        'onboardingScreen': (context) => const StartScreen(),
        'usersTypeScreen': (context) => const UserTypeScreen(),
        'getOTP': (context) => const OTPScreen(),
        'geminiChatBot': (context) => const GeminiChatBot(),
        'careerQuiz': (context) => const CareerQuiz(),
        'studentSignUp': (context) => const StudentSignUpScreen(),
        'studentLogin': (context) => const StudentLoginScreen(),
        'studentHome': (context) => const StudentScreen(),
        'teacherLogin': (context) => const TeacherLoginScreen(),
        'teacherSignUp': (context) => const TeacherSignUpScreen(),
        'teacherHome': (context) => const TeacherScreen(),
      },
    );
  }
}
