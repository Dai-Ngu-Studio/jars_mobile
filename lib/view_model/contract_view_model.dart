import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';

import '../data/models/contract.dart';
import '../data/repository/contract_repository_impl.dart';

class ContractViewModel extends ChangeNotifier {
  final _contracttionRepo = ContractRepositoryImpl();

  ApiResponse<List> contract = ApiResponse.loading();

  void _setContract(ApiResponse<List> response) {
    contract = response;
    notifyListeners();
  }

  Future<bool> addContract({
    required token, 
    required Contract contract
  }) async {
    _setContract(ApiResponse.loading());
    try {
      await _contracttionRepo.addContract(
       contract: contract,
       token: token,
      );
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future getContracts({
    required String idToken,
    num? size,
    num? page,
    }) async {
    _setContract(ApiResponse.loading());
    await _contracttionRepo
        .getContracts(
          token: idToken,
          size: size,
          page: page,
        )
        .then(((value) => _setContract(ApiResponse.completed(value))))
        .onError(
          (error, stackTrace) => _setContract(
            ApiResponse.error(error.toString()),
          ),
        );
  }
  Future<Contract> getContract({
    required String idToken,
    required int contractID,
  }) async {
    return await _contracttionRepo.getContract(idToken: idToken, contractId: contractID);
  }
}