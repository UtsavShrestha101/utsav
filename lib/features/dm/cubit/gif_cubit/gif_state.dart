// ignore_for_file: public_member_api_docs, sort_constructors_first
class GifState {
  final String? query;
  final List<String> gifUrls;
  final String? errorMessage;
  final bool isLoading;

  GifState({
    this.query,
    this.gifUrls = const [],
    this.errorMessage,
    this.isLoading = false,
  });

  GifState copyWith({
    String? query,
    List<String>? gifUrls,
    String? errorMessage,
    bool? isLoading,
  }) {
    return GifState(
      query: query ?? this.query,
      gifUrls: gifUrls ?? this.gifUrls,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
