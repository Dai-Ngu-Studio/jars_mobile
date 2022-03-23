import 'package:jars_mobile/data/models/bill.dart';

abstract class BillRepository {
  Future<Bill> getBill({required String idToken, required int billId});

  Future<Bill> createBill({
    required String idToken,
    required String name,
    required String date,
    required List<dynamic> billDetails,
  });
}
