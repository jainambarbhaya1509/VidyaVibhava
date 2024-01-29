import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider = StateProvider<File?>((ref) => null);
final aadharProvider = StateProvider<File?>((ref) => null);
final incomeProvider = StateProvider<File?>((ref) => null);

class DocumentUploadSection extends ConsumerStatefulWidget {
  const DocumentUploadSection({Key? key}) : super(key: key);

  @override
  ConsumerState<DocumentUploadSection> createState() =>
      _DocumentUploadSectionState();
}

class _DocumentUploadSectionState extends ConsumerState<DocumentUploadSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future uploadProfileImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      ref.read(imageProvider.notifier).state = imageTemp;
    } on PlatformException {
      const CircularProgressIndicator();
    }
  }

  Future uploadAadharCard() async {
    final aadharCard = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    aadharCard != null
        ? ref.read(aadharProvider.notifier).state =
            File(aadharCard.files.single.path!)
        : null;
    if (aadharCard == null) return;
  }

  Future uploadIncomeCertificate() async {
    final incomeCertificate = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    incomeCertificate != null
        ? ref.read(incomeProvider.notifier).state =
            File(incomeCertificate.files.single.path!)
        : null;
    if (incomeCertificate == null) return;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final image = ref.watch(imageProvider);
    final aadhar = ref.watch(aadharProvider);
    final income = ref.watch(incomeProvider);
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
          margin: const EdgeInsets.only(left: 30,),
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
            GestureDetector(
              onTap: () => uploadProfileImage(ImageSource.camera),
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: image == null ? Colors.grey : Colors.green,
                    width: 1,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        image == null ? Icons.camera_alt_outlined : Icons.check,
                        color: image == null ? Colors.grey : Colors.green,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      image == null
                          ? GeneralAppText(
                              text: "Camera",
                              size: MediaQuery.of(context).size.width * 0.033,
                              weight: FontWeight.bold,
                              color: Colors.grey,
                            )
                          : PrimaryAppText(
                              text: "Image Uploaded",
                              size: MediaQuery.of(context).size.width * 0.033,
                              weight: FontWeight.bold,
                              color: Colors.green,
                            )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => uploadProfileImage(ImageSource.gallery),
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: image == null ? Colors.grey : Colors.green,
                    width: 1,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(image == null ? Icons.image_outlined : Icons.check,
                          color: image == null ? Colors.grey : Colors.green),
                      const SizedBox(
                        height: 10,
                      ),
                      image == null
                          ? GeneralAppText(
                              text: "Gallery",
                              size: MediaQuery.of(context).size.width * 0.033,
                              weight: FontWeight.bold,
                              color: Colors.grey,
                            )
                          : PrimaryAppText(
                              text: "Image Uploaded",
                              size: MediaQuery.of(context).size.width * 0.033,
                              weight: FontWeight.bold,
                              color: Colors.green,
                            )
                    ],
                  ),
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
            GestureDetector(
              onTap: () => uploadAadharCard(),
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: aadhar == null ? Colors.grey : Colors.green,
                    width: 1,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        aadhar == null ? Icons.file_copy_outlined : Icons.check,
                        color: aadhar == null ? Colors.grey : Colors.green,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: aadhar == null
                            ? GeneralAppText(
                                text: "Aadhar Card",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : PrimaryAppText(
                                text: "Document Uploaded",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.green,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => uploadIncomeCertificate(),
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: income == null ? Colors.grey : Colors.green,
                    width: 1,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        income == null ? Icons.file_copy_outlined : Icons.check,
                        color: income == null ? Colors.grey : Colors.green,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: income == null
                            ? GeneralAppText(
                                text: "Income",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : PrimaryAppText(
                                text: "Document Uploaded",
                                size: MediaQuery.of(context).size.width * 0.033,
                                weight: FontWeight.bold,
                                color: Colors.green,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
