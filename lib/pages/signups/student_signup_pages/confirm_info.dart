import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:final_project/pages/signups/student_signup_pages/address_info.dart';
import 'package:final_project/pages/signups/student_signup_pages/document_upload.dart';
import 'package:final_project/pages/signups/student_signup_pages/personal_info.dart';
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

class _ConfirmInformationSectionState extends State<ConfirmInformationSection> {
  late ConfettiController controller;

  void showOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0.0,
        right: 0.0,
        left: 0.0,
        child: ConfettiWidget(
          confettiController: controller,
          blastDirection: pi / 2,
          particleDrag: 0.05,
          emissionFrequency: 0.1,
          numberOfParticles: 2,
          maxBlastForce: 20,
          minBlastForce: 10,
          gravity: 0.05,
          shouldLoop: false,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.orange,
            Colors.white,
          ],
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    controller.play();
  }

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final personalInfo = ref.watch(personalInfoProvider);
        final addressInfo = ref.watch(addressInfoProvider);
        final image = ref.watch(imageProvider);

        String year = (now.year - int.parse(personalInfo["dob"].split("-")[2]))
            .toString();

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
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: image == null
                              ? const AssetImage('assets/images/user.png')
                              : FileImage(image) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GeneralAppText(
                            text: personalInfo["fname"] +
                                " " +
                                personalInfo["lname"],
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              GeneralAppText(
                                text: personalInfo["gender"],
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
                              GeneralAppText(
                                text: personalInfo["dob"] + " (" + year + ")",
                                size: 15,
                                weight: FontWeight.normal,
                              ),
                            ],
                          ),
                          GeneralAppText(
                            text: personalInfo["phone"],
                            size: 15,
                          ),
                          GeneralAppText(
                            text: personalInfo["username"],
                            size: 15,
                            weight: FontWeight.w500,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GeneralAppText(
                text: addressInfo["address"],
                size: 15,
                weight: FontWeight.normal,
              ),
              GeneralAppText(
                text: addressInfo["city"] +
                    " " +
                    addressInfo["zipCode"] +
                    ", " +
                    addressInfo["state"],
                size: 15,
                weight: FontWeight.normal,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    showOverlay(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 30),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green, width: 0.9),
                    ),
                    child: PrimaryAppText(
                      text: 'Proceed',
                      size: MediaQuery.of(context).size.width * 0.04,
                      weight: FontWeight.normal,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
