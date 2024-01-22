import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/sticker.dart';
import 'package:saro/core/repository/room_repository.dart';

part 'sticker_state.dart';

@injectable
class StickerCubit extends Cubit<StickerState> {
  final RoomRepository _repository;
  StickerCubit(this._repository) : super(StickerInitial());

  Future<void> getSticker() async {
    try {
      emit(StickerLoading());
      List<Sticker> stickersList = await _repository.getSticker();
      emit(StickerLoaded(stickersList));
    } on NetworkException catch (e) {
      emit(
        StickerFailure(e.message),
      );
    }
  }
}
