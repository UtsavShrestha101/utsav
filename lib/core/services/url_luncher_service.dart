import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@singleton
class UrlLuncherService {
  Future<void> launchUrlFromApp(String url, String authToken) async {
    try {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.inAppBrowserView,
          webViewConfiguration: WebViewConfiguration(
              headers: <String, String>{"Authorization": authToken}));
    } catch (e) {
      log(e.toString());
    }
  }
}
