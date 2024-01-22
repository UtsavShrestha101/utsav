import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/post_repository.dart';

part 'create_post_state.dart';

@injectable
class CreatePostCubit extends Cubit<CreatePostState> {
  final PostRepository _repository;
  CreatePostCubit(this._repository) : super(CreatePostState.initial());

  Future<void> uploadPost(
      String filePath, String description, bool isPremium) async {
    try {
      emit(CreatePostState.creating());
      String postId = await _repository.uploadPost(
        filePath,
        isPremium,
        description,
      );
      emit(
        CreatePostState.success(
          postId,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        CreatePostState.failure(
          e.message,
        ),
      );
    }
  }

  void changeBestieOnlyStatus(bool value) {
    emit(state.copyWith(bestieOnly: value));
  }

  void changeMessage(String message) {
    emit(state.copyWith(message: message));
  }
}
