import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/providers/role_provider.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadSection extends ConsumerStatefulWidget {
  const DocumentUploadSection({super.key});

  @override
  ConsumerState<DocumentUploadSection> createState() =>
      _DocumentUploadSectionState();
}

class _DocumentUploadSectionState extends ConsumerState<DocumentUploadSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future uploadStudentProfileImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      ref.read(studentImageProvider.notifier).state = imageTemp;
    } on PlatformException {
      const CircularProgressIndicator();
    }
  }

  Future uploadTeacherProfileImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      ref.read(teacherImageProvider.notifier).state = imageTemp;
    } on PlatformException {
      const CircularProgressIndicator();
    }
  }

  Future uploadStudentAadharCard() async {
    final aadharCard = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    aadharCard != null
        ? ref.read(studentAadharProvider.notifier).state =
            File(aadharCard.files.single.path!)
        : null;
    if (aadharCard == null) return;
  }

  Future uploadTeacherAadharCard() async {
    final aadharCard = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    aadharCard != null
        ? ref.read(teacherAadharProvider.notifier).state =
            File(aadharCard.files.single.path!)
        : null;
    if (aadharCard == null) return;
  }

  Future uploadIncomeCertificate() async {
    final incomeCertificate = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    incomeCertificate != null
        ? ref.read(studentIncomeProvider.notifier).state =
            File(incomeCertificate.files.single.path!)
        : null;
    if (incomeCertificate == null) return;
  }

  Future uploadTeacherCertificate() async {
    final teacherCertificate = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    teacherCertificate != null
        ? ref.read(teacherCertificateProvider.notifier).state =
            File(teacherCertificate.files.single.path!)
        : null;
    if (teacherCertificate == null) return;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final role = ref.watch(roleProvider);
    final studentImage = ref.watch(studentImageProvider);
    final studentAadhar = ref.watch(studentAadharProvider);

    final teacherImage = ref.watch(teacherImageProvider);
    final teacherAadhar = ref.watch(teacherAadharProvider);

    final income = ref.watch(studentIncomeProvider);
    final certificate = ref.watch(teacherCertificateProvider);

    // Student
    if (role == 'student') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30, top: 30),
            child: GeneralAppText(
              text: "Document Upload",
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 30,
            ),
            child: GeneralAppText(
              text: "Upload your image (camera/upload)",
              size: 15,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => uploadStudentProfileImage(ImageSource.camera),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: studentImage == null ? Colors.grey : Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          studentImage == null
                              ? Icons.camera_alt_outlined
                              : Icons.check,
                          color: studentImage == null ? Colors.grey : Colors.green,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        studentImage == null
                            ? GeneralAppText(
                                text: "Camera",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : PrimaryAppText(
                                text: "Image Uploaded",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.green,
                              )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => uploadStudentProfileImage(ImageSource.gallery),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: studentImage == null ? Colors.grey : Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(studentImage == null ? Icons.image_outlined : Icons.check,
                            color: studentImage == null ? Colors.grey : Colors.green),
                        const SizedBox(
                          height: 10,
                        ),
                        studentImage == null
                            ? GeneralAppText(
                                text: "Gallery",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : PrimaryAppText(
                                text: "Image Uploaded",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.green,
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: GeneralAppText(
              text: "Upload your documents",
              size: 15,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => uploadStudentAadharCard(),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: studentAadhar == null ? Colors.grey : Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          studentAadhar == null
                              ? Icons.file_copy_outlined
                              : Icons.check,
                          color: studentAadhar == null ? Colors.grey : Colors.green,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: studentAadhar == null
                              ? GeneralAppText(
                                  text: "Aadhar Card",
                                  size:
                                      MediaQuery.of(context).size.width * 0.033,
                                  weight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                              : PrimaryAppText(
                                  text: "Document Uploaded",
                                  size:
                                      MediaQuery.of(context).size.width * 0.033,
                                  weight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => uploadIncomeCertificate(),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: income == null ? Colors.grey : Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          income == null
                              ? Icons.file_copy_outlined
                              : Icons.check,
                          color: income == null ? Colors.grey : Colors.green,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: income == null
                              ? GeneralAppText(
                                  text: "Income Certificate",
                                  size:
                                      MediaQuery.of(context).size.width * 0.033,
                                  weight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                              : PrimaryAppText(
                                  text: "Document Uploaded",
                                  size:
                                      MediaQuery.of(context).size.width * 0.033,
                                  weight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );

      // Teacher
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30, top: 30),
            child: GeneralAppText(
              text: "Document Upload",
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 30,
            ),
            child: GeneralAppText(
              text: "Upload your image (camera/upload)",
              size: 15,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => uploadTeacherProfileImage(ImageSource.camera),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: teacherImage == null ? Colors.grey : Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          teacherImage == null
                              ? Icons.camera_alt_outlined
                              : Icons.check,
                          color: teacherImage == null ? Colors.grey : Colors.green,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        teacherImage == null
                            ? GeneralAppText(
                                text: "Camera",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : PrimaryAppText(
                                text: "Image Uploaded",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.green,
                              )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => uploadTeacherProfileImage(ImageSource.gallery),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: teacherImage == null ? Colors.grey : Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(teacherImage == null ? Icons.image_outlined : Icons.check,
                            color: teacherImage == null ? Colors.grey : Colors.green),
                        const SizedBox(
                          height: 10,
                        ),
                        teacherImage == null
                            ? GeneralAppText(
                                text: "Gallery",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : PrimaryAppText(
                                text: "Image Uploaded",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.green,
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: GeneralAppText(
              text: "Upload your documents",
              size: 15,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => uploadTeacherAadharCard(),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: teacherAadhar == null ? Colors.grey : Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          teacherAadhar == null
                              ? Icons.file_copy_outlined
                              : Icons.check,
                          color: teacherAadhar == null ? Colors.grey : Colors.green,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: teacherAadhar == null
                              ? GeneralAppText(
                                  text: "Aadhar Card",
                                  size:
                                      MediaQuery.of(context).size.width * 0.033,
                                  weight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                              : PrimaryAppText(
                                  text: "Document Uploaded",
                                  size:
                                      MediaQuery.of(context).size.width * 0.033,
                                  weight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => uploadTeacherCertificate(),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: certificate == null ? Colors.grey : Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          certificate == null
                              ? Icons.file_copy_outlined
                              : Icons.check,
                          color:
                              certificate == null ? Colors.grey : Colors.green,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: certificate == null
                              ? GeneralAppText(
                                  text: "Certificate",
                                  size:
                                      MediaQuery.of(context).size.width * 0.033,
                                  weight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                              : PrimaryAppText(
                                  text: "Document Uploaded",
                                  size:
                                      MediaQuery.of(context).size.width * 0.033,
                                  weight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }
  }
}
