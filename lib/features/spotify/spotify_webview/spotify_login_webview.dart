import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/features/spotify/spotify_widget/cubit/spotify_auth_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyLoginWebView extends StatefulWidget {
  final String url;
  final String authToken;
  final SpotifyAuthCubit spotifyAuthCubit;
  const SpotifyLoginWebView({
    super.key,
    required this.url,
    required this.authToken,
    required this.spotifyAuthCubit,
  });

  @override
  State<SpotifyLoginWebView> createState() => _SpotifyLoginWebViewState();
}

class _SpotifyLoginWebViewState extends State<SpotifyLoginWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(onUrlChange: (UrlChange urlChange) {
        if (urlChange.url!.contains("https://dev.saro.love")) {
          widget.spotifyAuthCubit.checkLogInSuccess();
          context.pop(true);
        }
      }))
      ..loadRequest(
        Uri.parse(widget.url),
        headers: {
          "Authorization": widget.authToken,
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
