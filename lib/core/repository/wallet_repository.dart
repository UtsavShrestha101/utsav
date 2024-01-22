import 'package:injectable/injectable.dart';
import 'package:saro/core/base/base_repository.dart';

@lazySingleton
class WalletRepository extends BaseRepository {
  WalletRepository(super.dio, super.database);

  static const _addCard = '/wallet/cards';
  static const _transferAmount = '/wallet/transfer';
  static String _deleteCard(String cardId) => '/wallet/cards/$cardId';

  Future<void> addCard(Map<String, String> cardDetail) async {
    await makeDioRequest<void>(
      () async {
        await dio.post(
          _addCard,
          data: cardDetail,
        );
      },
    );
  }

  Future<void> deleteCard(String cardID) async {
    await makeDioRequest<void>(
      () async {
        await dio.delete(
          _deleteCard(cardID),
        );
      },
    );
  }

  Future<void> transferAmount(double amount, String userId) async {
    final data = {
      "amount": amount,
      "userId": userId,
    };
    await makeDioRequest<void>(
      () async {
        await dio.post(
          _transferAmount,
          data: data,
        );
      },
    );
  }
}
