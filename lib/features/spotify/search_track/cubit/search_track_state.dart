import 'package:equatable/equatable.dart';
import 'package:saro/core/models/spotify_searched_track.dart';

class SearchTrackState extends Equatable {
  final String query;
  final List<SpotifySearchedTrack> result;
  final bool isSearching;
  final String? errorMessage;
  final bool loadMore;
  final bool hasReachedEnd;

  const SearchTrackState(
    this.query,
    this.result,
    this.isSearching,
    this.errorMessage,
    this.loadMore,
    this.hasReachedEnd,
  );
  SearchTrackState copyWith({
    String? query,
    List<SpotifySearchedTrack>? result,
    bool? isSearching,
    String? errorMessage,
    bool? loadMore,
    bool? hasReachedEnd,
  }) {
    return SearchTrackState(
      query ?? this.query,
      result ?? this.result,
      isSearching ?? this.isSearching,
      errorMessage,
      loadMore ?? this.loadMore,
      hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props =>
      [query, result, isSearching, errorMessage, loadMore, hasReachedEnd];

  SearchTrackState.initial() : this('', [], false, null, false, false);

  bool get isSearchResultEmpty =>
      !isSearching && query.isNotEmpty && result.isEmpty;
}
