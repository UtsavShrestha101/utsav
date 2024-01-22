import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/base/base_repository.dart';

@lazySingleton
class GifRepository extends BaseRepository {
  static const _giphyUrl =
      "https://api.giphy.com/v1/gifs/search?api_key=nnkS0aSqfEKl0IFHYsRAzqZawrxSIB47";
  GifRepository(super.dio, super.database);

  Future<List<String>> getFollowingsPost(String gifQuery) async {
    return makeDioRequest<List<String>>(() async {
      List<String> gifList = [];
      final params = {
        "q": gifQuery,
        "limit": 15,
      };
      final response = await Dio().get(
        _giphyUrl,
        queryParameters: params,
      );

      for (var gif in (response.data['data'] as List)) {
        gifList.add(gif["images"]["original"]["url"]);
      }

      return gifList;
    });
  }
}
