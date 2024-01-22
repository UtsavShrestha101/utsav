import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/gif_repository.dart';
import 'package:saro/features/dm/cubit/gif_cubit/gif_state.dart';

@injectable
class GifCubit extends Cubit<GifState> {
  final GifRepository _gifRepository;
  GifCubit(this._gifRepository) : super(GifState());

  getGifData({String? query}) async {
    try {
      List<String> gifList =
          await _gifRepository.getFollowingsPost(query ?? "meme");

      emit(
        state.copyWith(
          gifUrls: [
            ...gifList,
          ],
          isLoading: false,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          isLoading: false,
        ),
      );
    }
  }
}
