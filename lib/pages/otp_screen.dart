import 'dart:math';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_text.dart';

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

  @override
  void initState() {
    super.initState();
    final random = Random();
    currentFact = facts[random.nextInt(facts.length)];
    userType = 0;
  }

  @override
  Widget build(BuildContext context) {
    final int args = ModalRoute.of(context)!.settings.arguments as int? ?? 0;
    final theme = ref.watch(appBarProvider.notifier).isLightMode;
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
              SizedBox(
                width: 300,
                height: 50,
                child: Pinput(
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
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, args == 0 ? 'studentLogin' : 'teacherLogin'),
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
                onTap: () => Navigator.pushNamed(
                    context, args == 0 ? 'studentHome' : 'teacherHome'),
                child: Container(
                  height: 50,
                  width: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryAppText(
                          text: 'Proceed',
                          size: 15,
                          weight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        GeneralAppIcon(
                          icon: Icons.arrow_forward_ios_rounded,
                          size: 15,
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
