// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:saro/app/cubit/app_cubit.dart' as _i51;
import 'package:saro/app/theme_cubit/theme_cubit.dart' as _i16;
import 'package:saro/core/di/dependency_injection.dart' as _i62;
import 'package:saro/core/models/post_detail.dart' as _i55;
import 'package:saro/core/repository/auth_repository.dart' as _i21;
import 'package:saro/core/repository/gif_repository.dart' as _i30;
import 'package:saro/core/repository/post_repository.dart' as _i9;
import 'package:saro/core/repository/push_notification_repository.dart' as _i10;
import 'package:saro/core/repository/room_repository.dart' as _i40;
import 'package:saro/core/repository/spotify_repository.dart' as _i47;
import 'package:saro/core/repository/user_repository.dart' as _i18;
import 'package:saro/core/repository/wallet_repository.dart' as _i20;
import 'package:saro/core/router/app_router.dart' as _i3;
import 'package:saro/core/services/audio_service.dart' as _i4;
import 'package:saro/core/services/database_service.dart' as _i8;
import 'package:saro/core/services/push_notification_service.dart' as _i11;
import 'package:saro/core/services/socket_service.dart' as _i15;
import 'package:saro/core/services/url_luncher_service.dart' as _i17;
import 'package:saro/features/auth/forgot_password/reset_password/cubit/reset_password_cubit.dart'
    as _i39;
import 'package:saro/features/auth/forgot_password/send_otp/cubit/send_otp_cubit.dart'
    as _i42;
import 'package:saro/features/auth/forgot_password/verify_otp/cubit/verify_otp_cubit.dart'
    as _i50;
import 'package:saro/features/auth/login/cubit/login_cubit.dart' as _i31;
import 'package:saro/features/auth/signup/signup_dob/cubit/signup_dob_cubit.dart'
    as _i14;
import 'package:saro/features/auth/signup/signup_email/cubit/signup_email_cubit.dart'
    as _i44;
import 'package:saro/features/auth/signup/signup_password/cubit/signup_password_cubit.dart'
    as _i45;
import 'package:saro/features/auth/signup/signup_username/cubit/signup_username_cubit.dart'
    as _i46;
import 'package:saro/features/dm/cubit/dm_bloc.dart' as _i53;
import 'package:saro/features/dm/cubit/gif_cubit/gif_cubit.dart' as _i56;
import 'package:saro/features/dm/cubit/sticker_cubit/sticker_cubit.dart'
    as _i48;
import 'package:saro/features/home/home_page/bloc/followings_post/followings_post_bloc.dart'
    as _i29;
import 'package:saro/features/home/home_page/cubit/my_post/my_post_cubit.dart'
    as _i32;
import 'package:saro/features/home/home_page/cubit/notification_count/notification_count_cubit.dart'
    as _i34;
import 'package:saro/features/home/home_page/cubit/rooms/room_cubit.dart'
    as _i57;
import 'package:saro/features/home/home_page/cubit/verify_user/verify_user_cubit.dart'
    as _i19;
import 'package:saro/features/notification/bloc/notification/notification_bloc.dart'
    as _i33;
import 'package:saro/features/post/create_post/cubit/create_post_cubit.dart'
    as _i28;
import 'package:saro/features/post/post_page/bloc/post/post_bloc.dart' as _i36;
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_bloc.dart'
    as _i13;
import 'package:saro/features/post/post_page/cubit/follower_post_detail/follower_post_cubit.dart'
    as _i54;
import 'package:saro/features/post/select_post/cubit/select_post_cubit.dart'
    as _i12;
import 'package:saro/features/profile/edit_profile/change_avatar/cubit/avatar_cubit.dart'
    as _i22;
import 'package:saro/features/profile/edit_profile/change_avatar/cubit/change_avatar_cubit.dart'
    as _i25;
import 'package:saro/features/profile/edit_profile/change_password/cubit/change_password_cubit.dart'
    as _i26;
import 'package:saro/features/profile/edit_profile/change_username/cubit/change_username_cubit.dart'
    as _i27;
import 'package:saro/features/profile/profile_page/bloc/peer/peer_bloc.dart'
    as _i35;
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart'
    as _i38;
import 'package:saro/features/profile/user_profile/bloc/user_profile_bloc.dart'
    as _i49;
import 'package:saro/features/search/cubit/search_cubit.dart' as _i41;
import 'package:saro/features/settings/cubit/premium_amount/premium_amount_cubit.dart'
    as _i37;
import 'package:saro/features/settings/cubit/profile_setting/profile_setting_cubit.dart'
    as _i43;
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_bloc.dart'
    as _i52;
import 'package:saro/features/spotify/search_track/cubit/search_track_cubit.dart'
    as _i58;
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_bloc.dart'
    as _i60;
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_track_bloc/spotify_playlist_tracks_bloc.dart'
    as _i61;
import 'package:saro/features/spotify/spotify_widget/cubit/spotify_auth_cubit.dart'
    as _i59;
import 'package:saro/features/wallet/cubit/balance_cubit/balance_cubit.dart'
    as _i23;
import 'package:saro/features/wallet/cubit/card_cubit/card_cubit.dart' as _i24;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.AppRouter>(_i3.AppRouter());
    gh.singleton<_i4.AudioService>(_i4.AudioService());
    gh.singleton<_i5.Dio>(registerModule.dio);
    gh.singleton<_i6.FlutterSecureStorage>(registerModule.flutterSecureStorage);
    gh.singleton<_i7.ImagePicker>(registerModule.imagePicker);
    await gh.singletonAsync<_i8.LocalDatabaseService>(
      () {
        final i = _i8.LocalDatabaseService(gh<_i6.FlutterSecureStorage>());
        return i.initialize().then((_) => i);
      },
      preResolve: true,
    );
    gh.lazySingleton<_i9.PostRepository>(() => _i9.PostRepository(
          gh<_i5.Dio>(),
          gh<_i8.LocalDatabaseService>(),
        ));
    gh.lazySingleton<_i10.PushNotificationRepository>(
        () => _i10.PushNotificationRepository(
              gh<_i5.Dio>(),
              gh<_i8.LocalDatabaseService>(),
            ));
    await gh.singletonAsync<_i11.PushNotificationService>(
      () {
        final i = _i11.PushNotificationService();
        return i.initialize().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i12.SelectPostCubit>(
        () => _i12.SelectPostCubit(gh<_i7.ImagePicker>()));
    gh.factoryParam<_i13.SelfPostDetailBloc, String, dynamic>((
      postId,
      _,
    ) =>
        _i13.SelfPostDetailBloc(
          gh<_i9.PostRepository>(),
          postId,
        ));
    gh.factory<_i14.SignupDobCubit>(() => _i14.SignupDobCubit());
    gh.singleton<_i15.SocketService>(
        _i15.SocketService(gh<_i8.LocalDatabaseService>()));
    gh.factory<_i16.ThemeCubit>(
        () => _i16.ThemeCubit(gh<_i8.LocalDatabaseService>()));
    gh.singleton<_i17.UrlLuncherService>(_i17.UrlLuncherService());
    gh.lazySingleton<_i18.UserRepository>(() => _i18.UserRepository(
          gh<_i5.Dio>(),
          gh<_i8.LocalDatabaseService>(),
        ));
    gh.factory<_i19.VerifyUserCubit>(
        () => _i19.VerifyUserCubit(gh<_i18.UserRepository>()));
    gh.lazySingleton<_i20.WalletRepository>(() => _i20.WalletRepository(
          gh<_i5.Dio>(),
          gh<_i8.LocalDatabaseService>(),
        ));
    gh.lazySingleton<_i21.AuthRepository>(() => _i21.AuthRepository(
          gh<_i5.Dio>(),
          gh<_i8.LocalDatabaseService>(),
        ));
    gh.factory<_i22.AvatarCubit>(
        () => _i22.AvatarCubit(gh<_i18.UserRepository>()));
    gh.factory<_i23.BalanceCubit>(
        () => _i23.BalanceCubit(gh<_i18.UserRepository>()));
    gh.factory<_i24.CardCubit>(() => _i24.CardCubit(
          gh<_i20.WalletRepository>(),
          gh<_i18.UserRepository>(),
        ));
    gh.factory<_i25.ChangeAvatarCubit>(
        () => _i25.ChangeAvatarCubit(gh<_i18.UserRepository>()));
    gh.factory<_i26.ChangePasswordCubit>(
        () => _i26.ChangePasswordCubit(gh<_i18.UserRepository>()));
    gh.factory<_i27.ChangeUsernameCubit>(
        () => _i27.ChangeUsernameCubit(gh<_i18.UserRepository>()));
    gh.factory<_i28.CreatePostCubit>(
        () => _i28.CreatePostCubit(gh<_i9.PostRepository>()));
    gh.factory<_i29.FollowingsPostBloc>(
        () => _i29.FollowingsPostBloc(gh<_i9.PostRepository>()));
    gh.lazySingleton<_i30.GifRepository>(() => _i30.GifRepository(
          gh<_i5.Dio>(),
          gh<_i8.LocalDatabaseService>(),
        ));
    gh.factory<_i31.LoginCubit>(() => _i31.LoginCubit(
          gh<_i21.AuthRepository>(),
          gh<_i10.PushNotificationRepository>(),
        ));
    gh.factory<_i32.MyPostCubit>(
        () => _i32.MyPostCubit(gh<_i9.PostRepository>()));
    gh.factory<_i33.NotificationBloc>(
        () => _i33.NotificationBloc(gh<_i18.UserRepository>()));
    gh.factory<_i34.NotificationCountCubit>(
        () => _i34.NotificationCountCubit(gh<_i18.UserRepository>()));
    gh.factory<_i35.PeerBloc>(() => _i35.PeerBloc(gh<_i18.UserRepository>()));
    gh.factoryParam<_i36.PostBloc, String, dynamic>((
      postId,
      _,
    ) =>
        _i36.PostBloc(
          gh<_i9.PostRepository>(),
          postId,
        ));
    gh.factory<_i37.PremiumAmountCubit>(
        () => _i37.PremiumAmountCubit(gh<_i18.UserRepository>()));
    gh.factory<_i38.ProfileCubit>(
        () => _i38.ProfileCubit(gh<_i18.UserRepository>()));
    gh.factory<_i39.ResetPasswordCubit>(
        () => _i39.ResetPasswordCubit(gh<_i21.AuthRepository>()));
    gh.lazySingleton<_i40.RoomRepository>(
      () => _i40.RoomRepository(
        gh<_i5.Dio>(),
        gh<_i8.LocalDatabaseService>(),
        gh<_i15.SocketService>(),
      )..listenToRoom(),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i41.SearchCubit>(
        () => _i41.SearchCubit(gh<_i18.UserRepository>()));
    gh.factory<_i42.SendOtpCubit>(
        () => _i42.SendOtpCubit(gh<_i21.AuthRepository>()));
    gh.factory<_i43.SettingCubit>(() => _i43.SettingCubit(
          gh<_i18.UserRepository>(),
          gh<_i21.AuthRepository>(),
        ));
    gh.factory<_i44.SignupEmailCubit>(
        () => _i44.SignupEmailCubit(gh<_i21.AuthRepository>()));
    gh.factory<_i45.SignupPasswordCubit>(() => _i45.SignupPasswordCubit(
          gh<_i21.AuthRepository>(),
          gh<_i10.PushNotificationRepository>(),
        ));
    gh.factory<_i46.SignupUsernameCubit>(
        () => _i46.SignupUsernameCubit(gh<_i21.AuthRepository>()));
    gh.lazySingleton<_i47.SpotifyRepository>(() => _i47.SpotifyRepository(
          gh<_i5.Dio>(),
          gh<_i8.LocalDatabaseService>(),
          gh<_i18.UserRepository>(),
        ));
    gh.factory<_i48.StickerCubit>(
        () => _i48.StickerCubit(gh<_i40.RoomRepository>()));
    gh.factoryParam<_i49.UserProfileBloc, String, dynamic>((
      userId,
      _,
    ) =>
        _i49.UserProfileBloc(
          gh<_i18.UserRepository>(),
          userId,
          gh<_i4.AudioService>(),
          gh<_i40.RoomRepository>(),
        ));
    gh.factory<_i50.VerifyOtpCubit>(
        () => _i50.VerifyOtpCubit(gh<_i21.AuthRepository>()));
    gh.factory<_i51.AppCubit>(() => _i51.AppCubit(gh<_i21.AuthRepository>()));
    gh.factory<_i52.AudioBloc>(() => _i52.AudioBloc(
          gh<_i4.AudioService>(),
          gh<_i8.LocalDatabaseService>(),
          gh<_i47.SpotifyRepository>(),
          gh<_i18.UserRepository>(),
        ));
    gh.factoryParam<_i53.DmBloc, String, List<String>>((
      roomId,
      userIds,
    ) =>
        _i53.DmBloc(
          gh<_i40.RoomRepository>(),
          roomId,
          userIds,
        ));
    gh.factoryParam<_i54.FollowingsPostDetailCubit, _i55.PostDetail, dynamic>((
      post,
      _,
    ) =>
        _i54.FollowingsPostDetailCubit(
          gh<_i9.PostRepository>(),
          post,
          gh<_i18.UserRepository>(),
          gh<_i40.RoomRepository>(),
        ));
    gh.factory<_i56.GifCubit>(() => _i56.GifCubit(gh<_i30.GifRepository>()));
    gh.factory<_i57.RoomCubit>(
        () => _i57.RoomCubit(gh<_i40.RoomRepository>())..init());
    gh.factory<_i58.SearchTrackCubit>(
        () => _i58.SearchTrackCubit(gh<_i47.SpotifyRepository>()));
    gh.factory<_i59.SpotifyAuthCubit>(() => _i59.SpotifyAuthCubit(
          gh<_i47.SpotifyRepository>(),
          gh<_i18.UserRepository>(),
        ));
    gh.factory<_i60.SpotifyPlaylistBloc>(
        () => _i60.SpotifyPlaylistBloc(gh<_i47.SpotifyRepository>()));
    gh.factoryParam<_i61.SpotifyPlaylistTracksBloc, String, dynamic>((
      playlistId,
      _,
    ) =>
        _i61.SpotifyPlaylistTracksBloc(
          gh<_i47.SpotifyRepository>(),
          playlistId,
        ));
    return this;
    
  }
}

class _$RegisterModule extends _i62.RegisterModule {}
