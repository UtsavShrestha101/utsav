part of 'sticker_cubit.dart';

abstract class StickerState {}

final class StickerInitial extends StickerState {}
final class StickerLoading extends StickerState {}

final class StickerLoaded extends StickerState {
  final List<Sticker> stickersList;

  StickerLoaded(this.stickersList);
}

final class StickerFailure extends StickerState {
  final String failureMsg;

  StickerFailure(this.failureMsg);
}
