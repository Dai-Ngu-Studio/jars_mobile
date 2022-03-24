import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/models/contract.dart';

abstract class ContractRepository {
  

  Future getContracts({required token,num? page,num? size});

  Future addContract({required token, required Contract contract});
  Future<Contract> getContract({required String idToken, required int contractId});
}
