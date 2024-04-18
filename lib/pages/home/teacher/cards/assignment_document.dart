import 'dart:async';

import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentDocument extends ConsumerStatefulWidget {
  final String? path;
  const AssignmentDocument({super.key, this.path});

  @override
  ConsumerState<AssignmentDocument> createState() => _AssignmentDocumentState();
}

class _AssignmentDocumentState extends ConsumerState<AssignmentDocument> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          forceMaterialTransparency: true,
          title: GeneralAppText(
            text: 'Document',
            size: 20,
            weight: FontWeight.bold,
            color: theme.isLightMode ? textColor1 : textColor2,
          )),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            onRender: (int? pages) {
              setState(() {
                pages = pages!;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}
