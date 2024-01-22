// ignore_for_file: unused_catch_clause

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/spotify_repository.dart';
import 'package:saro/features/spotify/search_track/cubit/search_track_state.dart';

@injectable
class SearchTrackCubit extends Cubit<SearchTrackState> {
  final SpotifyRepository _repository;
  SearchTrackCubit(this._repository) : super(SearchTrackState.initial());

  int _pageNumber = 1;
  Timer? _debounceTimer;
  static const int _debounceTimeInMs = 300;

  void search(String query) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    if (query.isEmpty) {
      emit(SearchTrackState.initial());
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
      final result = await _repository.searchTrack(page: _pageNumber,query: query);
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

  
}
