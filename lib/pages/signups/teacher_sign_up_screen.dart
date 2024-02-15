import 'package:final_project/pages/signups/signup_pages/address_info.dart';
import 'package:final_project/pages/signups/signup_pages/confirm_info.dart';
import 'package:final_project/pages/signups/signup_pages/document_upload.dart';
import 'package:final_project/pages/signups/signup_pages/organization_info.dart';
import 'package:final_project/pages/signups/signup_pages/personal_info.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toast/toast.dart';

class TeacherSignUpScreen extends ConsumerStatefulWidget {
  const TeacherSignUpScreen({super.key});

  @override
  ConsumerState<TeacherSignUpScreen> createState() =>
      _TeacherSignUpScreenState();
}

class _TeacherSignUpScreenState extends ConsumerState<TeacherSignUpScreen> {
  int currentPageIndex = 0;

  bool checkAllPersonalInfoFields() {
    final personalInfo = ref.read(personalInfoProvider);
    if (personalInfo['fname'] == '' ||
        personalInfo['lname'] == '' ||
        personalInfo['dob'] == '' ||
        personalInfo['gender'] == '' ||
        personalInfo['phone'] == '' ||
        // personalInfo['username'] == '' ||
        personalInfo['email'] == '') {
      return false;
    } else {
      return true;
    }
  }

  bool checkAllAddressInfoFields() {
    final addressInfo = ref.read(addressInfoProvider);
    if (addressInfo['address'] == '' ||
        addressInfo['city'] == '' ||
        addressInfo['state'] == '' ||
        addressInfo['zipCode'] == '') {
      return false;
    } else {
      return true;
    }
  }

  bool checkDocumentUpload() {
    final image = ref.read(imageProvider);
    final aadhar = ref.read(aadharProvider);
    final income = ref.read(incomeProvider);
    if (image == null || aadhar == null || income == null) {
      return false;
    } else {
      return true;
    }
  }

  bool checkOrganizationInfo() {
    final organizationInfo = ref.read(organizationInfoProvider);
    if (organizationInfo['organization'] == '' ||
        organizationInfo['subjects'] == []) {
      return false;
    } else {
      return true;
    }
  }

  final signUpSections = const [
    PersonalInformationSection(),
    AddressInformationSection(),
    DocumentUploadSection(),
    OrganizatonInformationSection(),
    ConfirmInformationSection()
  ];

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final signupController = PageController(
        initialPage: currentPageIndex, keepPage: true, viewportFraction: 1.0);

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
              margin: const EdgeInsets.only(
                left: 10,
                top: 50,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(signUpSections.length, (index) => index)
                    .map((e) {
                  Color indicatorColor;
                  if (currentPageIndex == e) {
                    indicatorColor = primaryColor;
                  } else if (currentPageIndex > e) {
                    indicatorColor = Colors.green;
                  } else {
                    indicatorColor = Colors.grey;
                  }
                  return Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 5,
                    decoration: BoxDecoration(
                      color: indicatorColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }).toList(),
              ),
            ),
            FittedBox(
              child: Container(
                margin: const EdgeInsets.only(left: 30, top: 60),
                child: GeneralAppText(
                  text: "Teacher Sign Up",
                  weight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
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
                controller: signupController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                children: signUpSections,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (currentPageIndex == 0) return;
                signupController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: PrimaryAppText(
                text: "Back",
                size: 20,
                color: currentPageIndex == 0 ? Colors.grey : primaryColor,
                weight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                int personalInfoIndex = signUpSections.indexWhere((widget) =>
                    widget.runtimeType == PersonalInformationSection);

                int addressInfoIndex = signUpSections.indexWhere((widget) =>
                    widget.runtimeType == AddressInformationSection);

                int documentUploadIndex = signUpSections.indexWhere(
                    (widget) => widget.runtimeType == DocumentUploadSection);

                int organizationInfoIndex = signUpSections.indexWhere(
                    (widget) => widget.runtimeType == OrganizatonInformationSection);

                if (currentPageIndex == personalInfoIndex &&
                    checkAllPersonalInfoFields() == false) {
                  Toast.show(
                    "Please fill all the fields",
                    duration: Toast.lengthLong,
                    gravity: Toast.bottom,
                  );
                  return;
                }

                if (currentPageIndex == addressInfoIndex &&
                    checkAllAddressInfoFields() == false) {
                  Toast.show(
                    "Please fill all the fields",
                    duration: Toast.lengthLong,
                    gravity: Toast.bottom,
                  );
                  return;
                }

                if (currentPageIndex == documentUploadIndex &&
                    checkDocumentUpload() == false) {
                  Toast.show(
                    "Please upload all the documents",
                    duration: Toast.lengthLong,
                    gravity: Toast.bottom,
                  );
                  return;
                }
                if(currentPageIndex == organizationInfoIndex &&
                    checkOrganizationInfo() == false) {
                  Toast.show(
                    "Please fill all the fields",
                    duration: Toast.lengthLong,
                    gravity: Toast.bottom,
                  );
                  return;
                }
                if (currentPageIndex == signUpSections.length - 1) return;

                signupController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: PrimaryAppText(
                text: "Next",
                size: 20,
                color: currentPageIndex == signUpSections.length - 1
                    ? Colors.grey
                    : primaryColor,
                weight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
