import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

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
