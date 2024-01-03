import 'package:final_project/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class TeacherSignUpScreen extends StatelessWidget {
  const TeacherSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: const CustomAppBar(),
      ),
      body: PageView(
        children: const [],
      ),
    );
  }
}
