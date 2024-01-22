import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/peer.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/profile/profile_page/bloc/peer/peer_event.dart';
import 'package:saro/features/profile/profile_page/bloc/peer/peer_state.dart';

@injectable
class PeerBloc extends Bloc<PeerEvent, PeerState> {
  final UserRepository _userRepository;

  PeerBloc(this._userRepository) : super(PeerState()) {
    on<LoadBestiezList>(loadBestiezList, transformer: droppable());
    on<LoadLurkersList>(loadLukersList, transformer: droppable());
  }

  Future<void> loadBestiezList(
    LoadBestiezList event,
    Emitter<PeerState> emit,
  ) async {
    try {
      if (!event.refreshList) {
        if (state.hasReachedEnd) return;
      }
      emit(
        state.copyWith(
          failureMsg: null,
          isLoading: true,
          page: event.refreshList ? 1 : state.page,
        ),
      );

      List<Peer> peer = await _userRepository.getBestiezList(state.page);

      emit(
        state.copyWith(
            isLoading: false,
            peerList: event.refreshList
                ? [...peer]
                : [
                    ...state.peerList,
                    ...peer,
                  ],
            page: state.page + 1,
            hasReachedEnd: peer.length < 10),
      );
    } on NetworkException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failureMsg: e.message,
      ));
    }
  }

  Future<void> loadLukersList(
    LoadLurkersList event,
    Emitter<PeerState> emit,
  ) async {
    try {
      if (!event.refreshList) {
        if (state.hasReachedEnd) return;
      }
      emit(
        state.copyWith(
          failureMsg: null,
          isLoading: true,
          page: event.refreshList ? 1 : state.page,
        ),
      );
      List<Peer> peer = await _userRepository.getLurkingList(state.page);

      emit(
        state.copyWith(
            isLoading: false,
            peerList: event.refreshList
                ? [...peer]
                : [
                    ...state.peerList,
                    ...peer,
                  ],
            page: state.page + 1,
            hasReachedEnd: peer.length < 10),
      );
    } on NetworkException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failureMsg: e.message,
      ));
    }
  }
}
