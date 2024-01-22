// ignore_for_file: unused_catch_clause

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/user_search_result.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/search/cubit/search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final UserRepository _repository;
  SearchCubit(this._repository) : super(SearchState.initial());

  int _pageNumber = 1;
  Timer? _debounceTimer;
  static const int _debounceTimeInMs = 300;

  void search(String query) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    if (query.isEmpty) {
      emit(SearchState.initial());
      return;
    }

    if (!state.isSearching) {
      _pageNumber = 1;
      emit(state.copyWith(
        isSearching: true,
        errorMessage: null,
        query: query,
        loadMore: false,
      ));
    }

    _debounceTimer = Timer(const Duration(milliseconds: _debounceTimeInMs), () {
      _perFormSearch(query);
    });
  }

  void loadMore() async {
    if (!state.loadMore && !state.hasReachedEnd) {
      emit(state.copyWith(loadMore: true));
      _pageNumber++;
      _perFormSearch(state.query);
    }
  }

  Future<void> _perFormSearch(String query) async {
    try {
      final result = await _repository.searchUser(_pageNumber, query);
      emit(
        state.copyWith(
          query: query,
          isSearching: false,
          result: state.loadMore
              ? [
                  ...state.result,
                  ...result,
                ]
              : result,
          hasReachedEnd: result.length < 10,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          query: query,
          isSearching: false,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> followUser(String userId) async {
    List<UserSearchResult> oldUserList = List.from(state.result);

    try {
      List<UserSearchResult> searchUserList = List.from(state.result);
      int index = searchUserList.indexWhere((element) => element.id == userId);
      if (index != -1) {
        searchUserList[index] =
            searchUserList[index].copyWith(isFollowing: true);
      }
      emit(
        state.copyWith(
          result: searchUserList,
          errorMessage: null,
        ),
      );
      await _repository.followUser(userId);
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          result: oldUserList,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> unFollowUser(String userId) async {
    List<UserSearchResult> oldUserList = List.from(state.result);
    try {
      List<UserSearchResult> searchUserList = List.from(state.result);
      int index = searchUserList.indexWhere((element) => element.id == userId);
      if (index != -1) {
        searchUserList[index] =
            searchUserList[index].copyWith(isFollowing: false);
      }
      emit(
        state.copyWith(result: searchUserList, errorMessage: null),
      );
      await _repository.unfollowUser(userId);
    } on NetworkException catch (e) {
      emit(
        state.copyWith(result: oldUserList, errorMessage: e.message),
      );
    }
  }

  void shareContent(String userId) {
    List<String> userIds = List.from(state.userIds);
    userIds.add(userId);
    emit(
      state.copyWith(userIds: userIds),
    );
  }
}
