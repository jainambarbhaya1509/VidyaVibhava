import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends ConsumerStatefulWidget {
  final url;
  const WebViewPage(this.url, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewPageState(this.url);
}

class _WebViewPageState extends ConsumerState<WebViewPage> {
  late final String url;
  final WebViewController webViewController = WebViewController();

  _WebViewPageState(this.url) {
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }// api call for the scholarships etc..
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    webViewController.reload();
  }
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
      body: Container(
        height: 1000,
        child: WebViewWidget(
          controller: webViewController
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(url)),
        ),
      ),
    );
  }
}
