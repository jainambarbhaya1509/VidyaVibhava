import 'package:final_project/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_text.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: const CustomAppBar(),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            buildOnboardingPage(
              image: 'assets/img/onboarding1.png',
              title: "Inspire",
              content:
                  "Step into a world where learning isn't just about facts but a journey that ignites a true passion for knowledge, fueling your curiosity with every click.",
            ),
            buildOnboardingPage(
              image: 'assets/img/onboarding2.png',
              title: "Transform",
              content:
                  "We're on a mission to elevate minds, offering a transformative experience with knowledge just a click away.",
            ),
            buildOnboardingPage(
              image: 'assets/img/onboarding3.png',
              title: "Empower",
              content:
                  "Experience the key to unlocking your potential—accessible anytime, anywhere, empowering you to shape your educational journey on your terms.",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? GestureDetector(
              onTap: () async {
                Navigator.pushReplacementNamed(context, 'usersTypeScreen');
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
              },
              child: Container(
                height: 100,
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GeneralAppText(
                      text: "Get Started",
                      color: Theme.of(context).primaryColor,
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GeneralAppIcon(
                      icon: Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 15,
                    )
                  ],
                ),
              ),
            )
          : Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.jumpToPage(2);
                    },
                    child:
                        // GeneralAppIcon(
                        //   icon: Icons.arrow_back_ios_rounded,
                        //   color: Colors.orange,
                        //   size: 20,
                        // ),
                        SizedBox(
                      width: 90,
                      height: 30,
                      child: FittedBox(
                        child: GeneralAppText(
                          text: "Skip",
                          color: Theme.of(context).primaryColor,
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                        dotHeight: 5,
                        spacing: 10,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.orange,
                      ),
                      onDotClicked: (index) {
                        controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                          height: 30,
                          child: FittedBox(
                            child: GeneralAppText(
                              text: "Next",
                              color: Theme.of(context).primaryColor,
                              size: 20,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GeneralAppIcon(
                          icon: Icons.arrow_forward_ios_rounded,
                          color: Colors.orange,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildOnboardingPage({
    required String image,
    required String title,
    required String content,
  }) =>
      Container(
        margin: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Image.asset(image),
            const SizedBox(
              height: 40,
            ),
            GeneralAppText(
              text: title,
              weight: FontWeight.bold,
              size: 25,
            ),
            const SizedBox(
              height: 20,
            ),
            GeneralAppText(
              text: content,
              weight: FontWeight.normal,
              size: 15,
              alignment: TextAlign.center,
            ),
          ],
        ),
      );
}
