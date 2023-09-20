import 'package:flutter/material.dart';
import 'package:safe_nails/common/analytics.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final String url =
      'https://codecloud-pp.blogspot.com/2023/04/politica-de-privacidade.html';

  @override
  void initState() {
    super.initState();
    sl<Analytics>().onScreenView(AnalyticsEventTags.terms_and_conditions_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Termos e Condições'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
