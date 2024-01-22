import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/base/base_repository.dart';
import 'package:saro/core/extensions/string_extension.dart';
import 'package:saro/core/models/post.dart';
import 'package:saro/core/models/post_detail.dart';

@lazySingleton
class PostRepository extends BaseRepository {
  PostRepository(super.dio, super.database);

  static const _followingsPost = '/posts/followings';
  static const _post = '/posts';
  static const _myPost = '/posts/my-latest';
  static String _report(String postId) => '/posts/$postId/reports';
  static String _like(String postId) => '/posts/$postId/likes';
  static String _dislike(String postId) => '/posts/$postId/dislikes';
  static String _view(String postId) => '/posts/$postId/viewers';
  static String _screenshot(String postId) => '/posts/$postId/screenshots';
  static String _delete(String postId) => '/posts/$postId';

  Future<String> uploadPost(
      String filePath, bool isPremium, String description) async {
    String fileName = filePath.split('/').last;
    String fileExtension = filePath.split('.').last;

    return await makeDioRequest<String>(() async {
      final queryParam = {
        "isPremium": isPremium,
        "description": description,
      };
      final data = FormData.fromMap(
        {
          'media': await MultipartFile.fromFile(
            filePath,
            filename: fileName,
            contentType: MediaType(
              filePath.mediaType(),
              fileExtension,
            ),
          ),
        },
      );
      final response = await dio.post(
        _post,
        data: data,
        options: Options(headers: {
          'Content-Type': "multipart/form-data;",
        }),
        queryParameters: queryParam,
      );

      return response.data['id'];
    });
  }

  Future<List<Post>> getFollowingsPost(int page) async {
    return makeDioRequest<List<Post>>(() async {
      final params = {"page": page, "limit": limit};

      final response = await dio.get(
        _followingsPost,
        queryParameters: params,
      );

      return (response.data['result'] as List)
          .map((e) => Post.fromJson(e))
          .toList();
    });
  }

  Future<List<PostDetail>> getFollowingsPostList(
      int page, String postId) async {
    return makeDioRequest<List<PostDetail>>(() async {
      final params = {
        "page": page,
        "limit": limit,
        "initial": postId,
      };

      final response = await dio.get(
        _post,
        queryParameters: params,
      );

      return (response.data['result'] as List)
          .map((postData) {
            postData.addAll(
              {
                "selfPost": postData["user"]["id"] == database.currentUser!.id
                    ? true
                    : false,
              },
            );
            return PostDetail.fromJson(postData);
          })
          .where(
            (postDetail) => postDetail.selfPost == false,
          )
          .toList();
    });
  }

  Future<List<PostDetail>> getAllPostList(int page, String postId) async {
    return makeDioRequest<List<PostDetail>>(() async {
      final params = {
        "page": page,
        "limit": limit,
        "initial": postId,
      };

      final response = await dio.get(
        _post,
        queryParameters: params,
      );

      return (response.data['result'] as List).map((postData) {
        postData.addAll(
          {
            "selfPost": postData["user"]["id"] == database.currentUser!.id
                ? true
                : false,
          },
        );
        return PostDetail.fromJson(postData);
      }).toList();
    });
  }

  Future<PostDetail> getSinglePost(String postId) async {
    return makeDioRequest<PostDetail>(() async {
      final params = {
        "page": 1,
        "limit": 1,
        "initial": postId,
      };

      final response = await dio.get(
        _post,
        queryParameters: params,
      );
      Map<String, dynamic> post = response.data['result'][0];
      post.addAll({
        "selfPost":
            post["user"]["id"] == database.currentUser!.id ? true : false,
      });

      return PostDetail.fromJson(post);
    });
  }

  Future<void> reportPost(String postId, String reportMsg) async {
    final data = {
      "message": reportMsg,
    };
    await makeDioRequest<void>(() async {
      await dio.post(
        _report(postId),
        data: data,
      );
    });
  }

  Future<void> likePost(
    String postId,
  ) async {
    await makeDioRequest<void>(() async {
      await dio.post(
        _like(postId),
      );
    });
  }

  Future<void> screenshotPost(
    String postId,
  ) async {
    await makeDioRequest<void>(() async {
      await dio.post(
        _screenshot(postId),
      );
    });
  }

  Future<void> unlikePost(
    String postId,
  ) async {
    await makeDioRequest<void>(() async {
      await dio.delete(
        _like(postId),
      );
    });
  }

  Future<void> dislikePost(
    String postId,
  ) async {
    await makeDioRequest<void>(() async {
      await dio.post(
        _dislike(postId),
      );
    });
  }

  Future<void> undislikePost(
    String postId,
  ) async {
    await makeDioRequest<void>(() async {
      await dio.delete(
        _dislike(postId),
      );
    });
  }



  Future<void> viewPost(String postId) async {
    await makeDioRequest<void>(() async {
      await dio.post(
        _view(postId),
      );
    });
  }

  Future<PostDetail?> myPost() async {
    return makeDioRequest<PostDetail?>(() async {
      final response = await dio.get(
        _myPost,
      );

      if (response.data != "") {
        return PostDetail.fromJson(response.data);
      }
      return null;
    });
  }

  Future<void> deletePost(String postId) async {
    return makeDioRequest<void>(() async {
      await dio.delete(
        _delete(postId),
      );
    });
  }

  Future<List<UserData>> likersList(String postId, int page) async {
    return makeDioRequest<List<UserData>>(() async {
      final params = {"page": page, "limit": limit};

      final response = await dio.get(
        _like(postId),
        queryParameters: params,
      );
      return (response.data['result'] as List)
          .map((e) => UserData.fromJson(e))
          .toList();
    });
  }

  Future<List<UserData>> screenshotTakersList(String postId, int page) async {
    return makeDioRequest<List<UserData>>(() async {
      final params = {"page": page, "limit": limit};

      final response = await dio.get(
        _screenshot(postId),
        queryParameters: params,
      );
      return (response.data['result'] as List)
          .map((e) => UserData.fromJson(e))
          .toList();
    });
  }

  Future<List<UserData>> dislikersList(String postId, int page) async {
    return makeDioRequest<List<UserData>>(() async {
      final params = {"page": page, "limit": limit};

      final response = await dio.get(
        _dislike(postId),
        queryParameters: params,
      );
      return (response.data['result'] as List)
          .map((e) => UserData.fromJson(e))
          .toList();
    });
  }

  Future<List<UserData>> viewerList(String postId, int page) async {
    return makeDioRequest<List<UserData>>(() async {
      final params = {"page": page, "limit": limit};

      final response = await dio.get(
        _view(postId),
        queryParameters: params,
      );
      return (response.data['result'] as List)
          .map((e) => UserData.fromJson(e))
          .toList();
    });
  }
}
