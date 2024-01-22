part of 'select_post_cubit.dart';

abstract class SelectPostState {}

class Initial extends SelectPostState {}

class MediaPickInProgress extends SelectPostState {}

class MediaPicked extends SelectPostState {
  final XFile file;

  MediaPicked(this.file);
}

class MediaPickedFailed extends SelectPostState {
  final String message;

  MediaPickedFailed(this.message);
}
