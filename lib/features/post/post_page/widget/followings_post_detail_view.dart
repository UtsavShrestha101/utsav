import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/action_list_tile.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/post/post_page/cubit/follower_post_detail/follower_post_cubit.dart';
import 'package:saro/features/post/post_page/cubit/follower_post_detail/follower_post_state.dart';
import 'package:saro/features/post/post_page/widget/expandable_caption_widget.dart';
import 'package:saro/features/post/post_page/widget/post_option_button.dart';
import 'package:saro/features/profile/user_profile/widget/share_list_view.dart';
import 'package:saro/features/search/widgets/search_field.dart';
import 'package:saro/features/wallet/cubit/card_cubit/card_cubit.dart';
import 'package:saro/features/wallet/cubit/card_cubit/card_state.dart';
import 'package:saro/resources/assets.gen.dart';
import 'package:screen_capture_event/screen_capture_event.dart';

class FollowingsPostDetailView extends StatefulWidget {
  final PostDetail post;
  const FollowingsPostDetailView({super.key, required this.post});

  @override
  State<FollowingsPostDetailView> createState() =>
      _FollowingsPostDetailViewState();
}

class _FollowingsPostDetailViewState extends State<FollowingsPostDetailView>
    with FormValidators {
  late final _followingsPostCubit =
      get<FollowingsPostDetailCubit>(param1: widget.post)
        ..postView()
        ..loadPost();
  final _iconSize = 45.0;
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();
  VoidCallback get clearText => _textController.clear;
  bool isCaptionViewExpanded = false;
  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();

  void toggleCaptionViewExpandState() {
    setState(() => isCaptionViewExpanded = !isCaptionViewExpanded);
  }

  @override
  void initState() {
    screenListener.addScreenShotListener((filePath) {
      _followingsPostCubit.screenshotPost();
    });

    ///Start watch
    screenListener.watch();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> showAlert() async {
    // Show the alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: AppColors.black.withOpacity(0.5),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/unlock_story.json",
                  height: 175,
                  width: 175,
                ),
                10.vSizedBox,
                Text(
                  "Thank you",
                  style: context.headlineLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
                20.vSizedBox,
                Text(
                  "Hope you like this subscription!",
                  style: context.bodyLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Delay for a few seconds and then close the alert
    await Future.delayed(
      const Duration(
        seconds: 6,
      ),
    );

    // Close the alert dialog
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => _followingsPostCubit,
      child: BlocConsumer<FollowingsPostDetailCubit, FollowingsPostDetailState>(
        listener: (context, state) {
          if (state.status == FollowingsPostDetailStatus.failure) {
            if (state.msg == "Card not found.") {
              addCardSheet(context);
            } else {
              context.showSnackBar(state.msg!);
            }
          } else if (state.status == FollowingsPostDetailStatus.success) {
            showAlert();
          } else {
            context.showSnackBar(state.msg!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.black.withOpacity(0.6),
            appBar: SaroAppBar(
              useDarkIcon: false,
              actions: [
                if (state.post.visible!)
                  InkWell(
                    onTap: () {
                      context.showBottomSheet(
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            25.vSizedBox,
                            ActionListTile(
                              leading: Assets.icons.saroReport.svg(width: 72),
                              title: 'Report',
                              onTap: () {
                                context.pop();
                                _showReportBottomSheet(
                                    context, _textController);
                              },
                            ),
                            25.vSizedBox,
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: Assets.icons.saroHamburger.svg(
                        height: 50,
                        width: 50,
                      ),
                    ),
                  )
              ],
            ),
            extendBodyBehindAppBar: true,
            body: BlocBuilder<FollowingsPostDetailCubit,
                FollowingsPostDetailState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    state.post.visible!
                        ? GestureDetector(
                            onDoubleTap: () {
                              if (!state.post.isLiked!) {
                                context
                                    .read<FollowingsPostDetailCubit>()
                                    .likePost();
                              } else {
                                context
                                    .read<FollowingsPostDetailCubit>()
                                    .unlikePost();
                              }
                            },
                            child: NetworkAssets(
                              key: ValueKey(state.post.filename!),
                              fileKey: widget.post.isPremium
                                  ? widget.post.id
                                  : widget.post.url!,
                              imgHeight: size.height,
                              imgWidth: size.width,
                              isPremiumContent: widget.post.isPremium,
                              isVideo: widget.post.filetype == FileType.video,
                            ),
                          )
                        : NetworkAssets(
                            fileKey: state.post.blurred!.url,
                            imgHeight: size.height,
                            imgWidth: size.width,
                          ),
                    if (!state.post.visible!)
                      InkWell(
                        onTap: () {
                          _showPremiumFollowSheet(context, state.post);
                        },
                        child: SizedBox(
                          height: size.height,
                          width: size.width,
                          child: Center(
                            child: Assets.icons.saroBestiesOnly.svg(
                              height: 250,
                              width: 250,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        height: 450,
                        width: size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ExpandableCaptionWidget(
                                    post: state.post,
                                    gotoProfilePage: true,
                                  )
                                ],
                              ),
                            ),
                            state.post.visible!
                                ? SizedBox(
                                    width: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        PostOptionButton(
                                          ontap: () {
                                            if (!state.post.isLiked!) {
                                              context
                                                  .read<
                                                      FollowingsPostDetailCubit>()
                                                  .likePost();
                                            } else {
                                              context
                                                  .read<
                                                      FollowingsPostDetailCubit>()
                                                  .unlikePost();
                                            }
                                          },
                                          widget: state.post.isLiked!
                                              ? Assets.icons.saroLove.svg(
                                                  height: _iconSize,
                                                  width: _iconSize,
                                                )
                                              : Assets.icons.saroLoveWhite.svg(
                                                  height: _iconSize,
                                                  width: _iconSize,
                                                ),
                                        ),
                                        PostOptionButton(
                                          ontap: () {
                                            if (!state.post.isDisliked!) {
                                              context
                                                  .read<
                                                      FollowingsPostDetailCubit>()
                                                  .dislikePost();
                                            } else {
                                              context
                                                  .read<
                                                      FollowingsPostDetailCubit>()
                                                  .undislikePost();
                                            }
                                          },
                                          widget: state.post.isDisliked!
                                              ? Assets.icons.saroHate.svg(
                                                  height: _iconSize,
                                                  width: _iconSize,
                                                )
                                              : Assets.icons.saroHateWhite.svg(
                                                  height: _iconSize,
                                                  width: _iconSize,
                                                ),
                                        ),
                                        PostOptionButton(
                                          ontap: () {
                                            _sendBoneBottomSheet(
                                                context, _textController);
                                            // print(widget.post.user.id);
                                          },
                                          widget: Assets.icons.saroBone.svg(
                                            height: _iconSize,
                                            width: _iconSize,
                                          ),
                                        ),
                                        PostOptionButton(
                                          ontap: () {
                                            _sendCommentBottomSheet(
                                                context, _textController);
                                          },
                                          widget: Assets.icons.saroMail.svg(
                                            height: _iconSize,
                                            width: _iconSize,
                                          ),
                                        ),
                                        PostOptionButton(
                                          ontap: () {
                                            _sharePostBottomSheet(
                                                context,
                                                _textController,
                                                state.post.user!,
                                                widget.post);
                                          },
                                          widget: Assets.icons.saroShare.svg(
                                            height: _iconSize,
                                            width: _iconSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _sendCommentBottomSheet(
      BuildContext context, TextEditingController textEditingController) {
    context.showBottomSheet(
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          vertical: 12.5,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      textEditingController: textEditingController,
                      label: 'say anything...',
                      showIcon: false,
                    ),
                  ),
                  5.hSizedBox,
                  InkWell(
                    onTap: () async {
                      await context
                          .read<FollowingsPostDetailCubit>()
                          .commentPost(textEditingController.text);
                      clearText();
                      if (context.mounted) context.pop();
                    },
                    child: Assets.icons.saroSend.svg(
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              ),
              if (Platform.isIOS) 12.5.vSizedBox
            ],
          ),
        ),
      ),
    );
  }

  void _sendBoneBottomSheet(
      BuildContext context, TextEditingController textEditingController) {
    context.showBottomSheet(
      BlocProvider(
        create: (context) => get<CardCubit>(),
        child: BlocConsumer<CardCubit, CardState>(
          listener: (BuildContext context, CardState state) {
            if (state.statusMsg != null) {
              context.showSnackBar(state.statusMsg!);
              context.pop();
            }
          },
          builder: (context, state) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                vertical: 12.5,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      leading: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Assets.icons.saroBone.svg(height: 46, width: 46),
                      ),
                      controller: _textController,
                      labelText: 'Send bone',
                      validator: isStringEmpty,
                      textInputType: TextInputType.number,
                    ),
                    10.vSizedBox,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: PrimaryButton(
                        isLoading: state.isLoading,
                        onPressed: () async {
                          if (isFormValid) {
                            await context.read<CardCubit>().transferAmount(
                                  double.parse(
                                    _textController.text.trim(),
                                  ),
                                  widget.post.user!.id,
                                );
                            clearText();
                          }
                        },
                        title: "Send",
                      ),
                    ),
                    if (Platform.isIOS) 12.5.vSizedBox
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showReportBottomSheet(
      BuildContext context, TextEditingController textEditingController) {
    context.showBottomSheet(
      Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              20.vSizedBox,
              AppTextField(
                validator: isStringEmpty,
                controller: textEditingController,
                labelText: 'Please write a problem',
                maxLines: 3,
              ),
              20.vSizedBox,
              16.vSizedBox,
              PrimaryButton(
                title: 'Report',
                onPressed: () async {
                  if (isFormValid) {
                    await context
                        .read<FollowingsPostDetailCubit>()
                        .reportPost(_textController.text);
                    clearText();
                    if (context.mounted) context.pop();
                  }
                },
              ),
              16.vSizedBox,
              Center(
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    "Cancel",
                    style: context.labelLarge,
                  ),
                ),
              ),
              16.vSizedBox,
            ],
          ),
        ),
      ),
    );
  }

  void addCardSheet(BuildContext context) {
    context.showBottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Please add your card",
            style: context.titleMedium,
          ),
          15.vSizedBox,
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              title: 'Add',
              onPressed: () async {
                context.go(AppRouter.wallet);
              },
            ),
          ),
          16.vSizedBox,
          Center(
            child: InkWell(
              onTap: () {
                context.pop();
              },
              child: Text(
                "Cancel",
                style: context.labelLarge,
              ),
            ),
          ),
          16.vSizedBox,
        ],
      ),
    );
  }

  void _showPremiumFollowSheet(BuildContext context, PostDetail postDetail) {
    context.showBottomSheet(
      BlocProvider.value(
        value: context.read<FollowingsPostDetailCubit>(),
        child:
            BlocBuilder<FollowingsPostDetailCubit, FollowingsPostDetailState>(
          builder: (context, state) {
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                20.vSizedBox,
                Center(
                  child: Text(
                    "for premium content",
                    style: context.titleMedium,
                  ),
                ),
                20.vSizedBox,
                Assets.icons.saroPremium.svg(
                  height: 125,
                  width: 125,
                ),
                Text(
                  "unlock all premium contents",
                  style: context.bodyLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  "Only a \$${postDetail.user!.premiumCharge} lifetime subscription grants exclusive access to his/her captivating content.",
                  style: context.bodySmall,
                  textAlign: TextAlign.center,
                ),
                20.vSizedBox,
                PrimaryButton(
                  title: 'upgrade to bestiez only',
                  onPressed: () async {
                    await context
                        .read<FollowingsPostDetailCubit>()
                        .premiumFollow();
                    if (context.mounted) context.pop();
                  },
                ),
                16.vSizedBox,
                Center(
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Text(
                      "Cancel",
                      style: context.labelLarge,
                    ),
                  ),
                ),
                16.vSizedBox,
              ],
            );
          },
        ),
      ),
    );
  }

  void _sharePostBottomSheet(
      BuildContext context,
      TextEditingController textEditingController,
      UserData user,
      PostDetail post) {
    context.showBottomSheet(
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          vertical: 12.5,
        ),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Share with",
                style: context.labelMedium,
              ),
              5.vSizedBox,
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: NetworkAssets(
                        key: ValueKey(
                          post.filename!,
                        ),
                        fileKey: !post.isPremium
                            ? post.filetype == FileType.image
                                ? post.url ?? ""
                                : post.placeholder!.url
                            : post.placeholder != null
                                ? post.placeholder!.url
                                : post.blurred!.url,
                        maxHeight: 200,
                      ),
                    ),
                  ),
                  10.hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${user.username}",
                            style: context.bodyLarge,
                          ),
                          if (user.isIdentityVerified == true)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2.5,
                              ),
                              child: Assets.icons.saroVerify.svg(
                                height: 28,
                                width: 28,
                              ),
                            ),
                        ],
                      ),
                      5.vSizedBox,
                    ],
                  )
                ],
              ),
              10.vSizedBox,
              ShareListView(
                textEditingController: _textController,
                share: (String profileId) {
                  context
                      .read<FollowingsPostDetailCubit>()
                      .sharePost(profileId);
                },
              ),
              if (Platform.isIOS) 12.5.vSizedBox
            ],
          ),
        ),
      ),
    );
  }
}
