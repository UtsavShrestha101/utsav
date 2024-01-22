import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/action_list_tile.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/dm/widgets/bone_tile.dart';
import 'package:saro/features/profile/user_profile/bloc/user_profile_bloc.dart';
import 'package:saro/features/profile/user_profile/widget/share_list_view.dart';
import 'package:saro/features/search/widgets/search_field.dart';
import 'package:saro/resources/assets.gen.dart';
import 'package:screen_capture_event/screen_capture_event.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;
  const UserProfilePage({super.key, required this.userId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with FormValidators {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final imageSize = 80.0;
  bool get isFormValid => _formKey.currentState!.validate();
  VoidCallback get clearText => _textController.clear;
  late final _userProfileBloc = get<UserProfileBloc>(param1: widget.userId)
    ..add(FetchDataState());
  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();

  @override
  void initState() {
    screenListener.addScreenShotListener((filePath) {
      _userProfileBloc.add(ScreenShotUserProfileState());
    });

    ///Start watch
    screenListener.watch();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _userProfileBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userProfileBloc,
      child: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state.msg != null) {
            context.showSnackBar(state.msg!);
          } else if (state.roomUser != null) {
            context.push('/rooms/${state.roomId}/dms', extra: {
              "userIds": state.userIds,
              "receiver": state.roomUser,
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state.user != null
                ? Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SaroAppBar(
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  context.showBottomSheet(
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        25.vSizedBox,
                                        ActionListTile(
                                          leading: Assets.icons.saroReport
                                              .svg(width: 72),
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
                                child: Assets.icons.saroHamburger.svg(
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  UserProfileAvatar(
                                    key: ValueKey(state.user!.avatar),
                                    userAvatar: state.user!.avatar,
                                    imgHeight: 150,
                                    imgWidth: 150,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "@${state.user!.username}",
                                        style: context.bodyLarge,
                                      ),
                                      if (state.user!.isIdentityVerified ==
                                          true)
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
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (state.isFollowing == true) {
                                    context
                                        .read<UserProfileBloc>()
                                        .add(UnFollowUserState());
                                  } else {
                                    context
                                        .read<UserProfileBloc>()
                                        .add(FollowUserState());
                                  }
                                },
                                child: state.isFollowing == true
                                    ? Assets.icons.saroFollowed.svg(
                                        height: imageSize,
                                        width: imageSize,
                                      )
                                    : Assets.icons.saroFollow.svg(
                                        height: imageSize,
                                        width: imageSize,
                                      ),
                              ),
                            ],
                          ),
                          10.vSizedBox,
                          const DottedLine(
                            lineThickness: 1.0,
                            dashColor: AppColors.grey,
                          ),
                          10.vSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (state.roomId != null) {
                                    context.read<UserProfileBloc>().add(
                                          DmUserState(),
                                        );
                                  } else {
                                    _sendCommentBottomSheet(
                                      context,
                                      _textController,
                                    );
                                  }
                                },
                                child: Assets.icons.saroMail.svg(
                                  height: imageSize,
                                  width: imageSize,
                                ),
                              ),
                              Assets.icons.pinkSqueak.svg(
                                height: imageSize,
                                width: imageSize,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.showBottomSheet(
                                    BoneTile(
                                      receiverId: widget.userId,
                                      shouldPopOnSend: true,
                                    ),
                                  );
                                },
                                child: Assets.icons.saroBone.svg(
                                  height: imageSize,
                                  width: imageSize,
                                ),
                              ),
                            ],
                          ),
                          10.vSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (state.user!.tracks!.isNotEmpty) {
                                    if (state.isAudioPlaying) {
                                      context.read<UserProfileBloc>().add(
                                            AudioStopEvent(),
                                          );
                                    } else {
                                      context.read<UserProfileBloc>().add(
                                            AudioPlayEvent(
                                              state
                                                  .user!.tracks![0].previewUrl!,
                                            ),
                                          );
                                    }
                                  } else {
                                    context.showSnackBar("No track added");
                                  }
                                },
                                child: state.isAudioPlaying
                                    ? Lottie.asset(
                                        "assets/animations/speaker_play.json",
                                        height: imageSize,
                                        width: imageSize,
                                      )
                                    : Assets.icons.saroSpotifyPlay.svg(
                                        height: imageSize,
                                        width: imageSize,
                                      ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _shareProfileBottomSheet(
                                    context,
                                    _textController,
                                    state.user!,
                                  );
                                },
                                child: Assets.icons.saroShare.svg(
                                  height: imageSize,
                                  width: imageSize,
                                ),
                              ),
                            ],
                          ),
                          10.vSizedBox,
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: LoadingIndicator(
                      height: 100,
                      width: 100,
                    ),
                  ),
          );
        },
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
                    context
                        .read<UserProfileBloc>()
                        .add(ReportUserState(_textController.text));
                    clearText();
                    if (context.mounted) context.pop();
                  }
                },
              ),
              16.vSizedBox,
              Center(
                child: GestureDetector(
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
                      context
                          .read<UserProfileBloc>()
                          .add(SendMessageState(_textController.text));
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

  void _shareProfileBottomSheet(
    BuildContext context,
    TextEditingController textEditingController,
    User user,
  ) {
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
                  UserProfileAvatar(
                    key: ValueKey(user.avatar),
                    userAvatar: user.avatar,
                    imgHeight: 110,
                    imgWidth: 110,
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
              5.vSizedBox,
              ShareListView(
                textEditingController: _textController,
                share: (String profileId) {
                  context.read<UserProfileBloc>().add(
                        ShareProfileState(
                          profileId,
                        ),
                      );
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
