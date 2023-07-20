import 'package:flutter/material.dart';

import '../../config/providers.dart';
import '../../core/models/cep_model.dart';
import '../../data/datasources/local/cep_sources.dart';
import '../../data/datasources/remote/viacep_sources.dart';

class CepController extends DisposableProvider {
  final CepSources _sourcesLocal = CepSources();
  final ViaCepSources _sourcesViaCep = ViaCepSources();
  List<CepModel> listCeps = [];


  Future<void> getListCep(int userId) async {
    final list = await _sourcesLocal.getCeps(userId);
    listCeps = list;
    notifyListeners();
  }

  Future<CepModel?> getCep(String cep) async {
    return await _sourcesViaCep.getCep(cep);
  }

  Future<int> insertOrUpdateCep(CepModel cep, bool isUpdate) async {
    if(isUpdate){
      final result = await _sourcesLocal.updateCep(cep);
      if(result > 0){
        listCeps.add(cep);
        notifyListeners();
      }
      return result;
    }else{
      final result = await _sourcesLocal.registerCep(cep);
      if(result > 0){
        cep.id = result;
        listCeps.add(cep);
        notifyListeners();
      }
      return result;
    }
  }

  @override
  void disposeValues() {
    listCeps = [];
  }

}