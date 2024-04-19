import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class AssignmentDocument extends StatefulWidget {
  final String pdfUrl;

  const AssignmentDocument({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _AssignmentDocumentState createState() => _AssignmentDocumentState();
}

class _AssignmentDocumentState extends State<AssignmentDocument> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    _downloadAndLoadPdf();
  }

  Future<void> _downloadAndLoadPdf() async {
    try {
      final file = await downloadPdfFile(widget.pdfUrl);
      localFilePath = file.path;
      setState(() {});
    } catch (e) {
      errorMessage = e.toString();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (localFilePath != null) {
      File(localFilePath!).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (localFilePath == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Viewer'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: localFilePath!,
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

  Future<File> downloadPdfFile(String pdfUrl) async {
    final response = await http.get(Uri.parse(pdfUrl));
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/temp_file.pdf';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}