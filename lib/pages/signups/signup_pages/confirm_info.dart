import 'package:final_project/providers/role_provider.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

DateTime now = DateTime.now();

class ConfirmInformationSection extends StatefulWidget {
  const ConfirmInformationSection({super.key});

  @override
  State<ConfirmInformationSection> createState() =>
      _ConfirmInformationSectionState();
}

String calculateAge(String dob) {
  try {
    List<String> dobParts = dob.split("-");
    if (dobParts.length >= 3) {
      int birthYear = int.parse(dobParts[2]);
      int age = now.year - birthYear;
      return age.toString();
    }
  } catch (e) {
    rethrow;
  }
  return '';
}

class _ConfirmInformationSectionState extends State<ConfirmInformationSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final role = ref.watch(roleProvider);
        final studentPersonalInfo = ref.watch(stuentPersonalInfoProvider);
        final studentAddressInfo = ref.watch(studentAddressInfoProvider);
        final studentImage = ref.watch(studentImageProvider);

        final teacherPersonalInfo = ref.watch(teacherPersonalInfoProvider);
        final teacherAddressInfo = ref.watch(teacherAddressInfoProvider);
        final teacherImage = ref.watch(teacherImageProvider);

        return Container(
          margin: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: GeneralAppText(
                  text: "Confirm Information",
                  size: 20,
                  weight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    if (role == 'student') ...[
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: studentImage == null
                                ? const AssetImage('assets/images/user.png')
                                : FileImage(studentImage) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ] else ...[
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: teacherImage == null
                                ? const AssetImage('assets/images/user.png')
                                : FileImage(teacherImage) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(
                      width: 10,
                    ),
                    if (role == 'student') ...[
                      FittedBox(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SecondaryAppText(
                                text: studentPersonalInfo["fname"] +
                                    " " +
                                    studentPersonalInfo["lname"],
                                size: 20,
                                weight: FontWeight.bold,
                              ),
                              Row(
                                children: [
                                  SecondaryAppText(
                                    text: studentPersonalInfo["gender"],
                                    size: 15,
                                    weight: FontWeight.normal,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.brightness_1,
                                    size: 5,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecondaryAppText(
                                    text: studentPersonalInfo.containsKey("dob")
                                        ? '${studentPersonalInfo["dob"]} (${calculateAge(studentPersonalInfo["dob"])})'
                                        : 'DOB not available',
                                    size: 15,
                                    weight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              SecondaryAppText(
                                text: studentPersonalInfo["phone"],
                                size: 15,
                              ),
                              SecondaryAppText(
                                text: studentPersonalInfo["username"],
                                size: 15,
                                weight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SecondaryAppText(
                                text: teacherPersonalInfo["fname"] +
                                    " " +
                                    teacherPersonalInfo["lname"],
                                size: 20,
                                weight: FontWeight.bold,
                              ),
                              Row(
                                children: [
                                  SecondaryAppText(
                                    text: teacherPersonalInfo["gender"],
                                    size: 13,
                                    weight: FontWeight.normal,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.brightness_1,
                                    size: 5,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecondaryAppText(
                                    text: teacherPersonalInfo.containsKey("dob")
                                        ? '${teacherPersonalInfo["dob"]} (${calculateAge(teacherPersonalInfo["dob"])})'
                                        : 'DOB not available',
                                    size: 13,
                                    weight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              SecondaryAppText(
                                text: teacherPersonalInfo["phone"],
                                size: 13,
                              ),
                              SecondaryAppText(
                                text: teacherPersonalInfo["email"],
                                size: 13,
                                weight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (role == 'student') ...[
                SecondaryAppText(
                  text: studentAddressInfo["address"],
                  size: 15,
                  weight: FontWeight.normal,
                ),
                SecondaryAppText(
                  text: studentAddressInfo["city"] +
                      " " +
                      studentAddressInfo["zipCode"] +
                      ", " +
                      studentAddressInfo["state"],
                  size: 15,
                  weight: FontWeight.normal,
                ),
              ] else ...[
                SecondaryAppText(
                  text: teacherAddressInfo["address"],
                  size: 13,
                  weight: FontWeight.normal,
                ),
                SecondaryAppText(
                  text: teacherAddressInfo["city"] +
                      " " +
                      teacherAddressInfo["zipCode"] +
                      ", " +
                      teacherAddressInfo["state"],
                  size: 13,
                  weight: FontWeight.normal,
                ),
              ],
              const SizedBox(
                height: 20,
              ),
              if (role == 'teacher') ...[
                SecondaryAppText(
                  text:
                      '${ref.read(teacherOganizationInfoProvider)['organization']} ${ref.read(teacherOganizationInfoProvider)['cddaAffiliated'] == true ? " (CDDA Affiliated)" : ""}',
                  size: 12,
                  weight: FontWeight.normal,
                ),
                SecondaryAppText(
                  text: ref
                      .read(teacherOganizationInfoProvider)['subjects']
                      .join(", "),
                  size: 12,
                  weight: FontWeight.normal,
                ),
                PrimaryAppText(
                  text: ref.read(teacherOganizationInfoProvider)['isMentor']
                      ? "(Mentor)"
                      : '',
                  size: 15,
                  weight: FontWeight.bold,
                  color: primaryColor,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: GestureDetector(
              //     onTap: () {
              //       if (role == 'student') {
              //         Navigator.pushNamedAndRemoveUntil(
              //             context, 'studentLogin', (route) => false);
              //       } else {
              //         Navigator.pushNamedAndRemoveUntil(
              //             context, 'teacherLogin', (route) => false);
              //       }
              //     },
              //     child: Container(
              //       alignment: Alignment.center,
              //       margin: const EdgeInsets.only(right: 30),
              //       height: 50,
              //       width: MediaQuery.of(context).size.width * 0.3,
              //       padding: const EdgeInsets.symmetric(horizontal: 10),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(color: Colors.green, width: 0.9),
              //       ),
              //       child: PrimaryAppText(
              //         text: 'Proceed',
              //         size: MediaQuery.of(context).size.width * 0.04,
              //         weight: FontWeight.normal,
              //         color: Colors.green,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
