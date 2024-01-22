import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/repository/post_repository.dart';
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_event.dart';
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_state.dart';

@injectable
class SelfPostDetailBloc
    extends Bloc<SelfPostDetailEvent, SelfPostDetailState> {
  final PostRepository _postRepository;
  final String postId;

  SelfPostDetailBloc(this._postRepository, @factoryParam this.postId)
      : super(SelfPostDetailState()) {
    on<DeletePostEvent>(deletePostEvent);
    on<LoadLikesListEvent>(loadLikesList, transformer: droppable());
    on<LoadHateListEvent>(loadDislikeList, transformer: droppable());
    on<LoadLukersListEvent>(loadLukersList, transformer: droppable());
    on<LoadScreenshotTakersListEvent>(loadScreenshotTakersList,
        transformer: droppable());
  }

  Future<void> deletePostEvent(
      DeletePostEvent event, Emitter<SelfPostDetailState> emit) async {
    try {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.loading,
          error: null,
        ),
      );
      await _postRepository.deletePost(postId);
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.failure,
          error: e.message,
        ),
      );
    }
  }

  Future<void> loadLikesList(
      LoadLikesListEvent event, Emitter<SelfPostDetailState> emit) async {
    try {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.loading,
          error: null,
        ),
      );
      List<UserData> likersList = await _postRepository.likersList(
        postId,
        state.page,
      );
      emit(
        state.copyWith(
          page: state.page + 1,
          userData: [
            ...state.userData,
            ...likersList,
          ],
          status: SelfPostDetailStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.failure,
          error: e.message,
        ),
      );
    }
  }

  Future<void> loadDislikeList(
      LoadHateListEvent event, Emitter<SelfPostDetailState> emit) async {
    try {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.loading,
          error: null,
        ),
      );
      List<UserData> likersList = await _postRepository.dislikersList(
        postId,
        state.page,
      );
      emit(
        state.copyWith(
          page: state.page + 1,
          userData: [
            ...state.userData,
            ...likersList,
          ],
          status: SelfPostDetailStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.failure,
          error: e.message,
        ),
      );
    }
  }

  Future<void> loadLukersList(
      LoadLukersListEvent event, Emitter<SelfPostDetailState> emit) async {
    try {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.loading,
          error: null,
        ),
      );
      List<UserData> likersList = await _postRepository.viewerList(
        postId,
        state.page,
      );
      emit(
        state.copyWith(
          page: state.page + 1,
          userData: [
            ...state.userData,
            ...likersList,
          ],
          status: SelfPostDetailStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.failure,
          error: e.message,
        ),
      );
    }
  }

  Future<void> loadScreenshotTakersList(LoadScreenshotTakersListEvent event,
      Emitter<SelfPostDetailState> emit) async {
    try {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.loading,
          error: null,
        ),
      );
      List<UserData> likersList = await _postRepository.screenshotTakersList(
        postId,
        state.page,
      );
      emit(
        state.copyWith(
          page: state.page + 1,
          userData: [
            ...state.userData,
            ...likersList,
          ],
          status: SelfPostDetailStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: SelfPostDetailStatus.failure,
          error: e.message,
        ),
      );
    }
  }
}
