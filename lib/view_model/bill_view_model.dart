import 'package:jars_mobile/data/models/bill.dart';
import 'package:jars_mobile/data/repository/bill_repository_impl.dart';

class BillViewModel {
  final _billRepo = BillRepositoryImpl();

  Future<Bill> getBill({
    required String idToken,
    required int billId,
  }) async {
    return await _billRepo.getBill(idToken: idToken, billId: billId);
  }
}
