import 'package:injectable/injectable.dart';
import 'package:saro/core/base/base_repository.dart';
import 'package:saro/core/models/avatar.dart';
import 'package:saro/core/models/notification.dart';
import 'package:saro/core/models/peer.dart';
import 'package:saro/core/models/user_search_result.dart';

import '../models/user.dart';

@lazySingleton
class UserRepository extends BaseRepository {
  UserRepository(super.dio, super.database);

  static const _userMe = '/users/me';
  static const _userSearchPath = '/users/search';
  static const _changePassword = '/users/change-password';
  static const _changeUsername = '/users/change-username';
  static const _changeCharacter = '/users/change-avatar';
  static const _characters = "/characters";
  static const _notifications = "/notifications";
  static const _viewNotifications = "/notifications/viewed";
  static const _verifyUser = "/users/verify-email";
  static const _deleteUser = "/users/delete-account";
  static const _setPremiumAmount = "/users/premium-charge";
  static const _verificationSession = "/users/verification-session";

  User? get user => database.currentUser;
  String? get userId => database.currentUser!.id;

  String get _lurkings => "/users/$userId/lurkings";
  String get _besties => "/users/$userId/besties";

  static String _screenshot(String userId) => "/users/$userId/screenshots";

  static String _getUser(String userId) => '/users/$userId';
  static String _follow(String userId) => '/users/$userId/follow';
  static String _report(String userId) => '/users/$userId/report';

  static String _premiumfollow(String userId) =>
      '/users/$userId/follow/premium';
  static String _unFollow(String userId) => '/users/$userId/unfollow';

  Future<User> refreshCurrentUser() async {
    final user = await makeDioRequest<User>(() async {
      final response = await dio.get(_userMe);
      return User.fromJson(response.data);
    });

    await database.setCurrentUser(user);
    return user;
  }

  Future<void> changePassword(String password) async {
    final data = {
      "password": password,
    };
    await makeDioRequest<void>(() async {
      await dio.patch(
        _changePassword,
        data: data,
      );
    });
  }

  Future<void> changeUsername(String username) async {
    final data = {
      "username": username,
    };
    await makeDioRequest<void>(() async {
      await dio.patch(
        _changeUsername,
        data: data,
      );
    });
    User updatedUser = user!.copyWith(
      username: username,
    );
    await database.setCurrentUser(updatedUser);
  }

  Future<void> changeAvatar(String avatar, String avatarName) async {
    final data = {
      "avatar": avatar,
    };
    await makeDioRequest<void>(() async {
      await dio.patch(
        _changeCharacter,
        data: data,
      );
    });

    User updatedUser = user!.copyWith(
      avatar: avatarName,
    );
    await database.setCurrentUser(updatedUser);
  }

  Future<List<Avatar>> getCharacters() async {
    return makeDioRequest<List<Avatar>>(() async {
      final response = await dio.get(_characters);

      return (response.data['result'] as List)
          .map((e) => Avatar.fromJson(e))
          .toList();
    });
  }

  Future<List<Peer>> getLurkingList(
    int page,
  ) async {
    final params = {"page": page, "limit": limit};

    return makeDioRequest<List<Peer>>(() async {
      final response = await dio.get(
        _lurkings,
        queryParameters: params,
      );

      return (response.data['result'] as List)
          .map((e) => Peer.fromJson(e))
          .toList();
    });
  }

  Future<List<Peer>> getBestiezList(
    int page,
  ) async {
    final params = {"page": page, "limit": limit};

    return makeDioRequest<List<Peer>>(() async {
      final response = await dio.get(
        _besties,
        queryParameters: params,
      );

      return (response.data['result'] as List)
          .map((e) => Peer.fromJson(e))
          .toList();
    });
  }

  Future<User> getUserInfo(
    String userId,
  ) async {
    return makeDioRequest<User>(() async {
      final response = await dio.get(
        _getUser(userId),
      );
      User user = User.fromJson(response.data["user"]);
      user.isFollowing = response.data["misc"]["isFollowing"];
      user.roomId = response.data["misc"]["roomId"];
      return user;
    });
  }

  Future<List<UserSearchResult>> searchUser(int page, String query) async {
    return await makeDioRequest<List<UserSearchResult>>(
      () async {
        final params = {"page": page, "limit": limit, "search": query};

        final response =
            await dio.get(_userSearchPath, queryParameters: params);

        return (response.data['result'] as List)
            .map((json) => UserSearchResult.fromJson(json))
            .toList();
      },
    );
  }

  //unfollow-user
  Future<void> unfollowUser(String userId) async {
    await makeDioRequest<void>(() async {
      await dio.delete(
        _unFollow(userId),
      );
    });
  }

  //follow-user
  Future<void> followUser(String userId) async {
    await makeDioRequest<void>(() async {
      await dio.post(
        _follow(userId),
      );
    });
  }

  Future<void> screenshotUser(String userId) async {
    await makeDioRequest<void>(() async {
      await dio.post(
        _screenshot(userId),
      );
    });
  }

  //premium-follow-user
  Future<void> premiumfollowUser(String userId) async {
    await makeDioRequest<void>(() async {
      await dio.patch(
        _premiumfollow(userId),
      );
    });
  }

  //notification
  Future<List<UserNotification>> notificationList(
    String type,
    int page,
  ) async {
    final params = {
      "type": type,
      "page": page,
      "limit": 10,
    };

    return makeDioRequest<List<UserNotification>>(() async {
      final response = await dio.get(
        _notifications,
        queryParameters: params,
      );

      return (response.data['result'] as List)
          .map((e) => UserNotification.fromJson(e))
          .toList();
    });
  }

  Future<void> viewNotification() async {
    await makeDioRequest<void>(() async {
      await dio.patch(
        _viewNotifications,
      );
    });
  }

  Future<void> setPremiumAmount(double premiumAmount) async {
    final data = {
      "premiumCharge": premiumAmount,
    };
    await makeDioRequest<void>(() async {
      await dio.patch(
        _setPremiumAmount,
        data: data,
      );
    });
  }

  Future<void> sendVerifyOtp() async {
    await makeDioRequest<void>(() async {
      await dio.post(
        _verifyUser,
      );
    });
  }

  Future<void> verifyOtp(String otp) async {
    final data = {
      "otp": otp,
    };
    await makeDioRequest<void>(() async {
      await dio.patch(
        _verifyUser,
        data: data,
      );
    });
    User updatedUser = user!.copyWith(
      username: user!.username,
      avatar: user!.avatar ?? "",
      isEmailVerified: true,
    );
    await database.setCurrentUser(updatedUser);
  }

  //delete-user
  Future<void> deleteUser() async {
    await makeDioRequest<void>(() async {
      await dio.delete(
        _deleteUser,
      );
    });
  }

  //report-user
  Future<void> reportUser(String userId, String reportMsg) async {
    final data = {
      "message": reportMsg,
    };
    await makeDioRequest<void>(() async {
      await dio.post(
        _report(userId),
        data: data,
      );
    });
  }




  Future<String> verificationSession() async {
    return await makeDioRequest<String>(() async {
      final response = await dio.post(
        _verificationSession,
      );
      return response.data["url"];
    });
  }
}

