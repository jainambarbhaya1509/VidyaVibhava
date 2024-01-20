import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TeacherSignUpScreen extends StatefulWidget {
  const TeacherSignUpScreen({super.key});

  @override
  State<TeacherSignUpScreen> createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<TeacherSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    // final controller = PageController();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: const CustomAppBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // TODO: Step Sign Up
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, top: 100),
            child: GeneralAppText(
              text: "Teacher Sign Up",
              weight: FontWeight.bold,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.69,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.only(left: 30, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralAppText(
                    text: "Personal Information", // TODO: Make Dynamic
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  // TODO: Dynamic Fields
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
