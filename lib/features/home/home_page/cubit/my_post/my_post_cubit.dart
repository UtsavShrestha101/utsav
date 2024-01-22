import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/repository/post_repository.dart';
import 'package:saro/features/home/home_page/cubit/my_post/my_post_state.dart';

@injectable
class MyPostCubit extends Cubit<MyPostState> {
  final PostRepository _postRepository;
  MyPostCubit(this._postRepository)
      : super(
          MyPostState(),
        );

  Future<void> refreshPost() => loadPost();

  Future<void> loadPost() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          failureMsg: null,
        ),
      );

      PostDetail? myPost = await _postRepository.myPost();

      emit(
        state.copyWith(
          myPost: myPost,
          isLoading: false,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          failureMsg: e.message,
        ),
      );
    }
  }
}
