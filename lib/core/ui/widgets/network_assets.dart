import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/string_extension.dart';
import 'package:saro/core/flavor/flavor_config.dart';
import 'package:saro/core/services/database_service.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/resources/assets.gen.dart';

class NetworkAssets extends StatefulWidget {
  final String fileKey;
  final double? imgHeight;
  final double? imgWidth;
  final double? maxHeight;
  final bool? isVideo;
  final VoidCallback? onTap;
  final bool isPremiumContent;
  const NetworkAssets({
    super.key,
    required this.fileKey,
    this.imgHeight,
    this.maxHeight,
    this.imgWidth,
    this.onTap,
    this.isPremiumContent = false,
    this.isVideo = false,
  });

  @override
  State<NetworkAssets> createState() => _NetworkAssetsState();
}

class _NetworkAssetsState extends State<NetworkAssets> {
  late CachedVideoPlayerController _controller;

  final databaseService = get<LocalDatabaseService>();
  late Map<String, String> header = {
    'Authorization': 'Bearer ${databaseService.credentials!.accessToken}'
  };
  late String url = widget.isPremiumContent
      ? "${FlavorConfig.values.baseUrl}/posts/premium/${widget.fileKey}/file"
      : widget.fileKey;
  bool isVideoPlaying = true;

  toggleVideoPlayerState() {
    setState(() {
      isVideoPlaying = !isVideoPlaying;
    });
  }

  @override
  void initState() {
    if (widget.fileKey.mediaType() == "VIDEO" || widget.isVideo!) {
      _controller = CachedVideoPlayerController.network(
        url,
        httpHeaders: header,
      )
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((value) {
          _controller.play();
          isVideoPlaying = true;
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.fileKey.mediaType() == "VIDEO" || widget.isVideo!) {
      _controller.dispose();
      _controller.removeListener(() {});
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap,
      child: widget.fileKey.mediaType() == "SVG"
          ? CachedNetworkSVGImage(
              url,
              placeholder: const CircularProgressIndicator(
                color: AppColors.primary,
              ),
              errorWidget: const Icon(
                Icons.error,
                color: AppColors.errorColor,
              ),
              height: widget.imgHeight,
              width: widget.imgWidth,
              fadeDuration: const Duration(milliseconds: 500),
            )
          : widget.fileKey.mediaType() == "GIF"
              ? GifView.network(
                  widget.fileKey,
                  height: widget.imgHeight,
                  width: widget.imgWidth,
                  fit: BoxFit.cover,
                  headers: header,
                  progress: Center(
                    child: Assets.gif.saroSpinner.image(
                      height: 125,
                      width: 125,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : widget.fileKey.mediaType() == "VIDEO" || widget.isVideo!
                  ? _controller.value.isInitialized
                      ? GestureDetector(
                          onTap: () async {
                            toggleVideoPlayerState();
                            if (isVideoPlaying) {
                              await _controller.pause();
                            } else {
                              await _controller.play();
                            }
                          },
                          child: SizedBox(
                            height: size.height,
                            width: size.width,
                            child: CachedVideoPlayer(_controller),
                          ),
                        )
                      : Center(
                          child: Assets.gif.saroSpinner.image(
                            height: 125,
                            width: 125,
                          ),
                        )
                  : Container(
                      constraints: BoxConstraints(
                        maxHeight: widget.maxHeight ?? double.infinity,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: url,
                        height: widget.imgHeight,
                        width: widget.imgWidth,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return Center(
                            child: Assets.gif.saroSpinner.image(
                              height: 125,
                              width: 125,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) => const Center(
                          child: LoadingIndicator(
                            height: 45,
                            width: 45,
                          ),
                        ),
                        httpHeaders: header,
                      ),
                    ),
    );
  }
}
