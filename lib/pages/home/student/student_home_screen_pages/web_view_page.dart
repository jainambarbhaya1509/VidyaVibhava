import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends ConsumerStatefulWidget {
  const WebViewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends ConsumerState<WebViewPage> {
  final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse(
        'https://www.google.com')); // api call for the scholarships etc..

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        forceMaterialTransparency: true,
        title: GeneralAppText(
          text: "Explore Schemes",
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
