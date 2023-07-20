

import 'package:flutter/material.dart';

import '../../../core/models/cep_model.dart';
import '../../../core/repositories/remote_service.dart';
import '../../../utils/validations.dart';

class ViaCepSources extends RemoteServiceRepo {

  Future<CepModel?> getCep(String cep) async {
    try {
      final result = await httpCli.get(url: 'https://viacep.com.br/ws/${Validations.onlyNumbers(cep)}/json/');

      if(result.isSucess){
        Map<String, dynamic> map = result.data;
        CepModel model = CepModel.fromMapRemote(map);
        return model;
      }
    } on Exception catch (e) {
       debugPrint(e.toString());
    }
    return null;
  }
}