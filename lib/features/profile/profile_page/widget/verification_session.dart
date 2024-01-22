import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VerificationSessionPage extends StatefulWidget {
  final String url;
  final ProfileCubit profileCubit;
  const VerificationSessionPage({
    Key? key,
    required this.url,
    required this.profileCubit,
  }) : super(key: key);

  @override
  State<VerificationSessionPage> createState() =>
      _VerificationSessionPageState();
}

class _VerificationSessionPageState extends State<VerificationSessionPage> {
  var loadingPercentage = 0;

  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(AppColors.white)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      }, onUrlChange: (UrlChange urlChange) {
        if (urlChange.url!.endsWith("users/verification-callback")) {
          widget.profileCubit.refreshUserData();
          context.pop();
        }
      }))
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}