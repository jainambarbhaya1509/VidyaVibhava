import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/pages/signups/signup_pages/create_password.dart';
import 'package:final_project/pages/signups/signup_pages/personal_info.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditTeacherProfile extends ConsumerStatefulWidget {
  const EditTeacherProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditTeacherProfileState();
}

class _EditTeacherProfileState extends ConsumerState<EditTeacherProfile> {
  String? imagePath;

  Future updateImage() async {
    final updatedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (updatedImage != null) {
      final path = updatedImage.path;
      setState(() {
        imagePath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: GeneralAppText(
              text: "Edit Profile",
              weight: FontWeight.bold,
              size: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(100),
                  image: imagePath != null
                      ? DecorationImage(
                          image: FileImage(File(imagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: updateImage,
                child: GeneralAppText(
                  text: "Update Profile Picture",
                  size: 16,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralAppText(text: "Email", size: 16, weight: FontWeight.bold),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: theme.isLightMode
                      ? const Color.fromARGB(211, 228, 228, 228)
                      : const Color.fromARGB(255, 54, 54, 54),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: teacherEmailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralAppText(
                  text: "Phone Number", size: 16, weight: FontWeight.bold),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: theme.isLightMode
                      ? const Color.fromARGB(211, 228, 228, 228)
                      : const Color.fromARGB(255, 54, 54, 54),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: teacherPhoneController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralAppText(
                      text: "Password", size: 16, weight: FontWeight.bold),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.isLightMode
                                ? const Color.fromARGB(211, 228, 228, 228)
                                : const Color.fromARGB(255, 54, 54, 54),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: createPasswordController,
                            decoration: const InputDecoration(
                              hintText: "Old Password",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.isLightMode
                                ? const Color.fromARGB(211, 228, 228, 228)
                                : const Color.fromARGB(255, 54, 54, 54),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                              hintText: "New Password",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryAppText(
                    text: "Save Changes",
                    size: 16,
                    weight: FontWeight.bold,
                    color: primaryColor,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
