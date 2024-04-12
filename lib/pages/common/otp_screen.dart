import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/role_provider.dart';
import 'package:final_project/style/confetti.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_text.dart';

import '../../repository/authentication_repository.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  final List<String> facts = [
    'OTP enhances security by providing an additional layer of authentication beyond passwords.',
    'It mitigates the risk of unauthorized access, as OTPs are time-sensitive and valid for a short duration.',
    'OTP significantly reduces the impact of credential theft, as stolen OTPs become quickly obsolete.',
    'Multi-factor authentication, including OTPs, fortifies digital systems against various cyber threats.',
    'OTP adds an extra barrier against phishing attacks, as attackers would need more than just static credentials.',
    'In the event of a data breach, OTPs act as a safeguard, limiting the potential damage to user accounts.',
    'OTP is crucial for secure online transactions, ensuring that only authorized users can complete sensitive operations.',
    'It plays a pivotal role in identity verification, especially in situations requiring high levels of security.',
    'OTP usage aligns with compliance standards and regulatory requirements for robust data protection.',
    'By regularly changing and using OTPs, users contribute to a proactive security stance, staying one step ahead of potential threats.'
  ];

  late int userType;
  String currentFact = '';
  final otpController = TextEditingController();
  late ConfettiController controller;
  final focusNode = FocusNode();
  String? otpCode;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: const Duration(seconds: 1));
    final random = Random();
    currentFact = facts[random.nextInt(facts.length)];
    userType = 0;
  }

  @override
  void dispose() {
    controller.dispose();
    otpController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(roleProvider);
    final theme = ref.watch(settingsProvider.notifier).isLightMode;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: const CustomAppBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Image.asset('assets/img/otp.png'),
              ),
              const SizedBox(height: 10),
              FittedBox(
                child: Container(
                  alignment: Alignment.center,
                  width: 600,
                  child: GeneralAppText(
                    text: 'Enter Verification Code',
                    size: 30,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 100,
                child: Pinput(
                    controller: otpController,
                    focusNode: focusNode,
                    length: 6,
                    focusedPinTheme: PinTheme(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green),
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    validator: (value) {
                      print("\n\nValue" + value!);
                      otpCode = value;
                      print(otpCode);
                    },
                    onCompleted: (code) {
                      print("\n\n\n\nThe entered otp is " +
                          code +
                          "\n\n\n\n"); /*otpCode = code;*/
                    } /*async {
                    if(await AuthenticationRepository.instance.verifyOTP(code)){
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                    content: Text('OTP Validated !'),
                    ),
                    );
                    showConfetti(context);
                    if (role == 'student') {
                    Navigator.pushNamedAndRemoveUntil(
                    context, 'studentHome', (route) => false);
                    } else {
                    Navigator.pushNamedAndRemoveUntil(
                    context, 'teacherHome', (route) => false);
                    }
                    }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                    content: Text('Invalid OTP'),
                    ),
                    );
                    }
                  },*/
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                // padding: const EdgeInsets.symmetric(horizontal: 10,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (role == 'student') {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'studentLogin', (route) => false);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'teacherLogin', (route) => false);
                        }
                      },
                      child: FittedBox(
                        child: SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: GeneralAppText(
                            text: 'Change Number',
                            color: Colors.black.withOpacity(0.8),
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: FittedBox(
                        child: SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: GeneralAppText(
                            text: 'Resend Code',
                            color: Colors.black.withOpacity(0.8),
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  focusNode.unfocus();
                  print("OTP == $otpCode");

                  if (await AuthenticationRepository.instance
                      .verifyOTP(otpCode!)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('OTP Validated !'),
                      ),
                    );
                    showConfetti(context);
                    if (role == 'student') {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'studentHome', (route) => false);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'teacherHome', (route) => false);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid OTP'),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green, width: 1),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryAppText(
                          text: 'Proceed',
                          size: 10,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        GeneralAppIcon(
                          icon: Icons.arrow_forward_ios_rounded,
                          size: 10,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GeneralAppIcon(
                      icon: Icons.lightbulb,
                      size: 20,
                      color: theme ? textColor1 : textColor2,
                    ),
                    Expanded(
                      child: GeneralAppText(
                        text: 'Tip: $currentFact',
                        size: 15,
                        alignment: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
