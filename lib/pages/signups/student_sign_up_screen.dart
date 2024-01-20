import 'package:final_project/pages/signups/student_signup_pages/confirm_info.dart';
import 'package:final_project/pages/signups/student_signup_pages/document_upload.dart';
import 'package:final_project/pages/signups/student_signup_pages/personal_info.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

class StudentSignUpScreen extends StatefulWidget {
  const StudentSignUpScreen({super.key});

  @override
  State<StudentSignUpScreen> createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen> {
  bool isLastPage = true;
  bool isFirstPage = true;

  @override
  Widget build(BuildContext context) {
    final studentPageViewController = PageController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: const CustomAppBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                
                ),
            Container(
              margin: const EdgeInsets.only(left: 30, top: 80),
              child: GeneralAppText(
                text: "Student Sign Up",
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
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
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                child: PageView(
                  controller: studentPageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == 2;
                      isFirstPage = index == 0;
                    });
                  },
                  children: [
                    buildPersonalInformationSection(context),
                    buildDocumentUploadSection(context),
                    buildConfirmInfoSection(context)
                  ],
                )),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (isFirstPage) return;
                studentPageViewController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: PrimaryAppText(
                text: "Back",
                size: 20,
                color: isFirstPage ? Colors.grey : primaryColor,
                weight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (isLastPage) return;
                studentPageViewController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: PrimaryAppText(
                text: "Next",
                size: 20,
                color: isLastPage ? Colors.grey : primaryColor,
                weight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
// TODO: Step Sign Up
// TODO: Shared Preferences
// TODO: Form Validatiom
// TODO: Document Upload
// TODO: Navigate to login screen
// TODO: Confirm Information