import 'dart:io';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/extensions/string_extension.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/action_list_tile.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/cupertino_switch_button.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/post/create_post/cubit/create_post_cubit.dart';
import 'package:saro/features/post/post_page/bloc/post/post_event.dart';
import 'package:saro/resources/assets.gen.dart';

class CreatePostPage extends StatefulWidget {
  final XFile selectedFile;
  const CreatePostPage({super.key, required this.selectedFile});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> with FormValidators {
  late CachedVideoPlayerController _controller;
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();
  final _iconSize = 45.0;

  @override
  void initState() {
    super.initState();
    if (widget.selectedFile.path.mediaType() == "VIDEO") {
      _controller = CachedVideoPlayerController.file(
        File(
          widget.selectedFile.path,
        ),
      )
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((value) {
          _controller.play();
        });
    }
  }

  @override
  void dispose() {
    if (widget.selectedFile.path.mediaType() == "VIDEO") {
      _controller.dispose();
    }
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => get<CreatePostCubit>(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool value) async {
          if (!value) {
            alertPromptSheet(context);
          }
        },
        child: Scaffold(
          appBar: SaroAppBar(
            onBackButtonPress: () {
              alertPromptSheet(context);
            },
            centerTitle: true,
            text: 'My mood',
          ),
          extendBodyBehindAppBar: true,
          body: BlocConsumer<CreatePostCubit, CreatePostState>(
            listener: (context, state) {
              if (state.status == CreatePostStatus.success) {
                // context.pushNamed(AppRouter.home);
                context.pop();
                context.showSnackBar("Post created successfully");
                context.pushNamed(
                  AppRouter.postPage,
                  extra: {
                    "postId": state.postId,
                    "postEvent": LoadAllPostList(),
                  },
                );
              } else if (state.status == CreatePostStatus.failure) {
                context.showSnackBar(state.failureMessage!);
              }
            },
            builder: (context, state) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Center(
                    child: widget.selectedFile.path.mediaType() != "VIDEO"
                        ? Image.file(
                            File(
                              widget.selectedFile.path,
                            ),
                            fit: BoxFit.cover,
                          )
                        : _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: CachedVideoPlayer(_controller),
                              )
                            : const LoadingIndicator(
                                height: 50,
                                width: 50,
                              ),
                  ),
                  state.status == CreatePostStatus.creating
                      ? Container(
                          color: AppColors.black.withOpacity(0.75),
                          height: double.infinity,
                          width: double.infinity,
                          child: const Center(
                            child: LoadingIndicator(
                              height: 125,
                              width: 125,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              );
            },
          ),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton.small(
              shape: const CircleBorder(),
              backgroundColor: AppColors.primary,
              child: Assets.icons.saroArrowDark.svg(width: 24),
              onPressed: () {
                _showPostModalBottomSheet(
                  context,
                  descriptionController,
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void _showPostModalBottomSheet(
      BuildContext context, TextEditingController descriptionController) {
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      builder: (_) {
        final createPostCubit = context.read<CreatePostCubit>();
        return BlocBuilder<CreatePostCubit, CreatePostState>(
          bloc: createPostCubit,
          builder: (context, state) => Padding(
            padding: EdgeInsets.only(
              right: 18,
              left: 18,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    20.vSizedBox,
                    AppTextField(
                      maxLength: 100,
                      controller: descriptionController,
                      labelText: 'Have a magical day',
                      helperText: 'Max 100 characters',
                      maxLines: 3,
                      onChanged: createPostCubit.changeMessage,
                    ),
                    20.vSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Super fun time',
                          style: context.labelLarge,
                        ),
                        CupertinoSwitchButton(
                          thumbColor: !state.bestieOnly
                              ? AppColors.primary
                              : AppColors.white,
                          trackColor: AppColors.primary.withOpacity(0.2),
                          activeColor: AppColors.primary,
                          value: state.bestieOnly,
                          onChanged: createPostCubit.changeBestieOnlyStatus,
                        ),
                      ],
                    ),
                    16.vSizedBox,
                    PrimaryButton(
                      title: 'Squeak',
                      onPressed: () {
                        if (isFormValid) {
                          createPostCubit.uploadPost(widget.selectedFile.path,
                              descriptionController.text, state.bestieOnly);
                          descriptionController.clear();
                          context.pop();
                        }
                      },
                    ),
                    16.vSizedBox,
                    if (Platform.isIOS) 12.5.vSizedBox
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void alertPromptSheet(BuildContext context) {
    context.showBottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Want to cancel the post?",
            style: context.titleMedium,
          ),
          ActionListTile(
            onTap: () {
              context.pop();
              context.pop();
            },
            leading: Assets.icons.saroDelete.svg(
              height: _iconSize,
              width: _iconSize,
            ),
            title: "discard Post",
          ),
          ActionListTile(
            onTap: () {
              context.pop();
            },
            leading: Assets.icons.saroLove.svg(
              height: _iconSize,
              width: _iconSize,
            ),
            title: "continue Post",
          ),
          if (Platform.isIOS) 12.5.vSizedBox
        ],
      ),
    );
  }
}
