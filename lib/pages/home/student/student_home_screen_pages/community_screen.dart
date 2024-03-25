import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const StudentHomeScreen(),
                    //   ),
                    // );
                  },
                  child: GeneralAppIcon(
                    icon: Icons.arrow_back_ios_rounded,
                    color: primaryColor,
                    size: 22,
                  )),
              const SizedBox(width: 10),
              GeneralAppText(
                text: 'Community',
                size: 22,
                weight: FontWeight.bold,
              ),
            ],
          )),
      body: Container(),
    );
  }
}
