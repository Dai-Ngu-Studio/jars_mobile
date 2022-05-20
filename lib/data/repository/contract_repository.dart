import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/models/contract.dart';

abstract class ContractRepository {
  

  Future getContracts({required token,num? page,num? size});

  Future addContract({required token, required Contract contract});
  Future<Contract> getContract({required String idToken, required int contractId});
  Future updateContract({
    required String idToken,
    required int contractId,
    required int noteId,
    required String name,
    required String startDate,
    required String endDate,
    required num scheduleTypeId,
    required num amount,
    required String accountId,
    required String comment,
    double? longitude,
    double? latitude,
    String? image,
    String? addedDate,
  });
}
