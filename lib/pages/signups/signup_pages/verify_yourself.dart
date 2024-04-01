import 'package:final_project/pages/signups/signup_pages/personal_info.dart';
import 'package:final_project/providers/role_provider.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../../repository/authentication_repository.dart';

class VerifyYourself extends ConsumerStatefulWidget {
  const VerifyYourself({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyYourselfState();
}

class _VerifyYourselfState extends ConsumerState<VerifyYourself> {
  final verifyOtpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final role = ref.read(roleProvider);
    return Container(
      margin: const EdgeInsets.only(
        left: 30,
        top: 30,
        right: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppText(
            text: "Verify Yourself",
            size: 20,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                GeneralAppText(
                  text: role == "student"
                      ? "Enter your phone number"
                      : "Enter your email address",
                  size: 17,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (role == 'teacher') ...[
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: teacherEmailController,
                          onChanged: (value) {
                            ref.read(teacherPersonalInfoProvider)['email'] = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Email Address',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: GeneralAppIcon(
                            icon: Icons.arrow_forward_outlined,
                            size: 20,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ] else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          onChanged: (value) {
                            ref.read(stuentPersonalInfoProvider)['phone'] =
                                value;
                          },
                          controller: studentPhoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Phone Number',
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                '+91 |',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                           AuthenticationRepository.instance.phoneAuthentication(studentPhoneController.text);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: GeneralAppIcon(
                              icon: Icons.arrow_forward_outlined,
                              size: 20,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(
                  height: 20,
                ),
                GeneralAppText(
                  text: "Enter OTP",
                  size: 17,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Pinput(
                    controller: verifyOtpController,
                    length: 6,
                    focusedPinTheme: PinTheme(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green),
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                 onTap: () async{
                    if(await AuthenticationRepository.instance.verifyOTP(verifyOtpController.text)){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('OTP Validated ! Please Click Next'),
                        ),
                      );
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid OTP'),
                        ),
                      );
                    }
                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      height: 20,
                      child: GeneralAppText(
                        text: "Resend Code",
                        size: 15,
                      )),
                )
              ]),
        ],
      ),
    );
  }
}
