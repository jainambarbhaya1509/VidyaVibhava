import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

Widget buildConfirmInfoSection(BuildContext context){
  return Container(
    child:  Container(
          margin: const EdgeInsets.only(left: 30, top: 30),
          child: GeneralAppText(
            text: "Confirm Information",
            size: 20,
            weight: FontWeight.bold,
          ),
        ),
  );
}