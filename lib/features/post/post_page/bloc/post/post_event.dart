sealed class PostEvent {}

final class LoadCurrentPost extends PostEvent {}

final class LoadOthersPostList extends PostEvent {}

final class LoadAllPostList extends PostEvent {}
