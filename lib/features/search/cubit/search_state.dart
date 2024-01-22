import 'package:equatable/equatable.dart';
import 'package:saro/core/models/user_search_result.dart';

class SearchState extends Equatable {
  final String query;
  final List<UserSearchResult> result;
  final List<String> userIds;
  final bool isSearching;
  final String? errorMessage;
  final bool loadMore;
  final bool hasReachedEnd;

  const SearchState(
    this.query,
    this.result,
    this.isSearching,
    this.errorMessage,
    this.loadMore,
    this.hasReachedEnd, {
    this.userIds = const [],
  });
  SearchState copyWith({
    String? query,
    List<UserSearchResult>? result,
    bool? isSearching,
    String? errorMessage,
    bool? loadMore,
    bool? hasReachedEnd,
    List<String>? userIds,
  }) {
    return SearchState(
      query ?? this.query,
      result ?? this.result,
      isSearching ?? this.isSearching,
      errorMessage,
      loadMore ?? this.loadMore,
      hasReachedEnd ?? this.hasReachedEnd,
      userIds: userIds ?? this.userIds,
    );
  }

  @override
  List<Object?> get props => [
        query,
        result,
        isSearching,
        errorMessage,
        loadMore,
        hasReachedEnd,
        userIds
      ];

  SearchState.initial() : this('', [], false, null, false, false, userIds: []);

  bool get isSearchResultEmpty =>
      !isSearching && query.isNotEmpty && result.isEmpty;
}
