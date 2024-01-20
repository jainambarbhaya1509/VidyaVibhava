import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

Widget buildDocumentUploadSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 30, top: 30),
        child: GeneralAppText(
          text: "Document Upload",
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 40,
      ),
      Container(
        margin: const EdgeInsets.only(left: 30),
        child: GeneralAppText(
          text: "Upload your image (camera/upload)",
          size: 15,
          weight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GeneralAppText(
                    text: "Camera",
                    size: 15,
                    weight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Icon(
                    Icons.photo_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GeneralAppText(
                    text: "Gallery",
                    size: 15,
                    weight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        margin: const EdgeInsets.only(left: 30),
        child: GeneralAppText(
          text: "Upload your documents",
          size: 15,
          weight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Icon(
                      Icons.file_copy_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GeneralAppText(
                      text: "Aadhar Card",
                      size: 15,
                      weight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ],
                ),
              )),
          Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Icon(
                      Icons.currency_rupee_rounded,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GeneralAppText(
                      text: "Income",
                      size: 15,
                      weight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ],
                ),
              )),
        ],
      )
    ],
  );
}
