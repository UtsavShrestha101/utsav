import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/models/room.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/features/auth/forgot_password/reset_password/reset_password_page.dart';
import 'package:saro/features/auth/forgot_password/verify_otp/verify_otp_page.dart';
import 'package:saro/features/auth/forgot_password/send_otp/send_otp_page.dart';
import 'package:saro/features/auth/login/login_page.dart';
import 'package:saro/features/auth/signup/signup_dob/signup_dob_page.dart';
import 'package:saro/features/auth/signup/signup_email/signup_email_page.dart';
import 'package:saro/features/auth/signup/signup_password/signup_password_page.dart';
import 'package:saro/features/auth/signup/signup_username/signup_username_page.dart';
import 'package:saro/features/dm/dm_page.dart';
import 'package:saro/features/home/home_page/cubit/notification_count/notification_count_cubit.dart';
import 'package:saro/features/home/home_page/home_page.dart';
import 'package:saro/features/post/post_page/widget/self_post_detail_page.dart';
import 'package:saro/features/post/post_page/post_page.dart';
import 'package:saro/features/post/create_post/create_post_page.dart';
import 'package:saro/features/post/select_post/select_post_page.dart';
import 'package:saro/features/profile/edit_profile/change_avatar/change_avatar_page.dart';
import 'package:saro/features/profile/edit_profile/change_password/change_password_page.dart';
import 'package:saro/features/profile/edit_profile/change_username/change_username_page.dart';
import 'package:saro/features/profile/edit_profile/edit_profile_page.dart';
import 'package:saro/features/profile/profile_page/widget/verification_session.dart';
import 'package:saro/features/profile/user_profile/user_profile_page.dart';
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart';
import 'package:saro/features/profile/profile_page/profile_page.dart';
import 'package:saro/features/settings/settings_page.dart';
import 'package:saro/features/search/search_page.dart';
import 'package:saro/features/settings/subscription_page.dart';
import 'package:saro/features/splash/splash_page.dart';
import 'package:saro/features/onboarding/onboarding_page.dart';
import 'package:saro/features/notification/notification_page.dart';
import 'package:saro/features/spotify/spotify_webview/spotify_login_webview.dart';
import 'package:saro/features/wallet/wallet_page.dart';

import 'scaffold_with_nav_bar.dart';

@singleton
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  //initial route
  static const splash = '/';

  //onboarding Routes
  static const onboarding = '/onboarding';
  static const login = 'login';
  static const signUpUsername = 'signupUsername';
  static const signUpDob = 'signupDob';
  static const signUpEmail = 'signupEmail';
  static const signUpPassword = 'signupPassword';

  //forgot
  static const forgotPasswordEmail = 'forgotPasswordEmail';
  static const forgotPasswordCode = 'forgotPasswordCode';
  static const forgotPasswordNewPassword = 'forgotPasswordNewPassword';

  static const resetPassword = 'resetpassword';

  //Home Routes
  static const home = '/home';
  static const selfPost = 'selfPost';
  static const postPage = 'postPage';

  static const search = '/search';

  static const notification = 'notification';

  static const wallet = '/wallet';

  //posts Route
  static const post = '/post';
  static const selectPost = 'select';
  static const createPost = 'create';

  //profileRoute
  static const profile = '/profile';
  static const userProfile = '/userprofile';

  //settingsRoute
  static const settings = '/settings';

  //edit-profile
  static const editProfile = 'editProfile';
  static const changeCharacter = 'changeCharacter';
  static const changeUsername = 'changeUsername';
  static const changePassword = 'changePassword';

  //edit-profile
  static const subscriptionPage = '/subscriptionPage';

  static const verificationSessionPage = '/verificationSessionPage';

  static const spotifyLoginPage = '/spotifyLoginPage';

  //dms
  static const dms = '/rooms/:id/dms';

  static Widget _splashBuilder(BuildContext context, GoRouterState state) =>
      const SplashPage();
  static Widget _onboardingBuilder(BuildContext context, GoRouterState state) =>
      const OnboardingPage();

  static Widget _verificationSessionBuilder(
      BuildContext context, GoRouterState state) {
    Map<String, dynamic> sessionData = state.extra as Map<String, dynamic>;

    return VerificationSessionPage(
      url: sessionData["url"],
      profileCubit: sessionData["cubit"],
    );
  }

  static Widget _spotifyLoginBuilder(
      BuildContext context, GoRouterState state) {
    Map<String, dynamic> sessionData = state.extra as Map<String, dynamic>;

    return SpotifyLoginWebView(
      url: sessionData["url"],
      authToken: sessionData["authToken"],
      spotifyAuthCubit: sessionData["cubit"],
    );
  }

  static Widget _loginBuilder(BuildContext context, GoRouterState state) =>
      const LoginPage();
  static Widget _signupUsernameBuilder(
          BuildContext context, GoRouterState state) =>
      const SignupUsernamePage();

  static Widget _signupDobBuilder(BuildContext context, GoRouterState state) {
    Map<String, String> userData = state.extra as Map<String, String>;
    return SignUpDobPage(username: userData["username"]!);
  }

  static Widget _signupEmailBuilder(BuildContext context, GoRouterState state) {
    Map<String, String> userData = state.extra as Map<String, String>;

    return SignUpEmailPage(
      username: userData["username"]!,
      dob: userData["dob"]!,
    );
  }

  static Widget _signupPasswordBuilder(
      BuildContext context, GoRouterState state) {
    Map<String, String> userData = state.extra as Map<String, String>;

    return SignUpPasswordPage(
      username: userData["username"]!,
      dob: userData["dob"]!,
      email: userData["email"]!,
    );
  }

  static Widget _forgotPasswordEmailBuilder(
          BuildContext context, GoRouterState state) =>
      const ForgotPasswordEmailPage();

  static Widget _forgotPasswordCodeBuilder(
      BuildContext context, GoRouterState state) {
    // Map<String, String> data = state.extra as Map<String, String>;
    Map<String, String> data = state.extra as Map<String, String>;
    return ForgotPasswordCodePage(
      email: data["email"]!,
    );
  }

  static Widget _forgotPasswordNewPasswordBuilder(
      BuildContext context, GoRouterState state) {
    Map<String, String> data = state.extra as Map<String, String>;

    return ForgotPasswordSetNewPage(
      token: data["token"]!,
    );
  }

  static Widget _homeBuilder(BuildContext context, GoRouterState state) =>
      HomePage();

  static Widget _postBuilder(BuildContext context, GoRouterState state) {
    Map<String, dynamic> postData = state.extra as Map<String, dynamic>;

    return PostPage(
      postId: postData["postId"]!,
      postEvent: postData["postEvent"],
      cubit: postData["cubit"],
    );
  }

  static Widget _selfPostBuilder(BuildContext context, GoRouterState state) {
    PostDetail postData = state.extra as PostDetail;

    return SelfPostDetailPage(
      post: postData,
    );
  }

  static Widget _profileBuilder(BuildContext context, GoRouterState state) =>
      const ProfileDetailsPage();

  static Widget _userBuilder(BuildContext context, GoRouterState state) =>
      UserProfilePage(
        userId: state.extra as String,
      );
  static Widget _searchBuilder(BuildContext context, GoRouterState state) =>
      const SearchPage();
  static Widget _notificationBuilder(
          BuildContext context, GoRouterState state) =>
      NotificationPage(
        notificationCountCubit: state.extra as NotificationCountCubit,
      );
  static Widget _walletBuilder(BuildContext context, GoRouterState state) =>
      WalletPage();
  static Widget _selectPostBuilder(BuildContext context, GoRouterState state) =>
      const SelectPostPage();
  static Widget _createPostBuilder(BuildContext context, GoRouterState state) =>
      CreatePostPage(selectedFile: state.extra as XFile);
  static Widget _settingsBuilder(BuildContext context, GoRouterState state) =>
      SettingsPage(
        profileCubit: state.extra as ProfileCubit,
      );

  static Widget _editProfileBuilder(
          BuildContext context, GoRouterState state) =>
      EditProfilePage(
        profileCubit: state.extra as ProfileCubit,
      );

  static Widget _changeCharacterBuilder(
          BuildContext context, GoRouterState state) =>
      ChangeAvatarPage(
        profileCubit: state.extra as ProfileCubit,
      );

  static Widget _changeUsernameBuilder(
          BuildContext context, GoRouterState state) =>
      ChangeUsernamePage(
        profileCubit: state.extra as ProfileCubit,
      );

  static Widget _changePasswordBuilder(
          BuildContext context, GoRouterState state) =>
      const ChangePasswordPage();

  static Widget _subscriptionBuilder(
          BuildContext context, GoRouterState state) =>
      const SubscriptionPage();

  static Widget _dmsBuilder(BuildContext context, GoRouterState state) {
    Map<String, dynamic> roomData = state.extra as Map<String, dynamic>;

    return DmPage(
      roomId: state.pathParameters['id']!,
      receiver: roomData['receiver'] as RoomUser,
      userIds: roomData["userIds"] as List<String>,
    );
  }

  static final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final credential = get<AuthRepository>().credentials;

      if (credential == null && state.matchedLocation == splash) {
        return onboarding;
      }

      if (credential != null && state.matchedLocation == splash) {
        return home;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: splash, builder: _splashBuilder),
      GoRoute(
        path: onboarding,
        name: onboarding,
        builder: _onboardingBuilder,
        routes: [
          GoRoute(
            path: login,
            name: login,
            builder: _loginBuilder,
          ),
          GoRoute(
            path: signUpUsername,
            name: signUpUsername,
            builder: _signupUsernameBuilder,
          ),
          GoRoute(
            path: signUpDob,
            name: signUpDob,
            builder: _signupDobBuilder,
          ),
          GoRoute(
            path: signUpEmail,
            name: signUpEmail,
            builder: _signupEmailBuilder,
          ),
          GoRoute(
            path: signUpPassword,
            name: signUpPassword,
            builder: _signupPasswordBuilder,
          ),
          GoRoute(
            path: forgotPasswordEmail,
            name: forgotPasswordEmail,
            builder: _forgotPasswordEmailBuilder,
          ),
          GoRoute(
            path: forgotPasswordCode,
            name: forgotPasswordCode,
            builder: _forgotPasswordCodeBuilder,
          ),
          GoRoute(
            path: forgotPasswordNewPassword,
            name: forgotPasswordNewPassword,
            builder: _forgotPasswordNewPasswordBuilder,
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        // navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: home,
              name: home,
              builder: _homeBuilder,
              routes: [
                GoRoute(
                  path: notification,
                  name: notification,
                  builder: _notificationBuilder,
                ),
              ],
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: search, name: search, builder: _searchBuilder)
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: post,
              name: post,
              builder: _selectPostBuilder,
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: createPost,
                  name: createPost,
                  builder: _createPostBuilder,
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: postPage,
                  name: postPage,
                  builder: _postBuilder,
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: selfPost,
                  name: selfPost,
                  builder: _selfPostBuilder,
                ),
              ],
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              name: wallet,
              path: wallet,
              builder: _walletBuilder,
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: profile,
              name: profile,
              builder: _profileBuilder,
            )
          ]),
        ],
      ),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: settings,
          name: settings,
          builder: _settingsBuilder,
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: editProfile,
              name: editProfile,
              builder: _editProfileBuilder,
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: changeCharacter,
                  name: changeCharacter,
                  builder: _changeCharacterBuilder,
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: changeUsername,
                  name: changeUsername,
                  builder: _changeUsernameBuilder,
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: changePassword,
                  name: changePassword,
                  builder: _changePasswordBuilder,
                ),
              ],
            ),
          ]),
      GoRoute(
        path: subscriptionPage,
        name: subscriptionPage,
        builder: _subscriptionBuilder,
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: verificationSessionPage,
        name: verificationSessionPage,
        builder: _verificationSessionBuilder,
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: spotifyLoginPage,
        name: spotifyLoginPage,
        builder: _spotifyLoginBuilder,
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: userProfile,
        name: userProfile,
        builder: _userBuilder,
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: dms,
        name: dms,
        builder: _dmsBuilder,
      )
    ],
  );

  static GoRouter get router => _router;
}
