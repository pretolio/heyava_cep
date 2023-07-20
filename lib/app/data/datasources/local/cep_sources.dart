


import '../../../core/models/cep_model.dart';
import '../../../core/repositories/local_service.dart';
import '../../../core/services/database/database_sqlite.dart';

class CepSources extends LocalServiceRepo{

  Future<List<CepModel>> getCeps(int idUser) async {
    List<CepModel> list = [];
    final Database _db = await data.db;
    final result = await _db.query(DBTableName.ceps.value,
        where: 'CEP_USR_ID = ?', whereArgs: [idUser]);
    list = result.map((e) => CepModel.fromMapLocal(e)).toList() ;
    return list;
  }

  Future<int> registerCep(CepModel cep) async {
    final Database _db = await data.db;
    final result = await _db.insert(DBTableName.ceps.value, cep.toMapInsert());
    return result;
  }

  Future<int> updateCep(CepModel cep) async {
    final Database _db = await data.db;
    final result = await _db.update(DBTableName.ceps.value, cep.toMapUpdate(),
        where: 'CEP_ID = ?', whereArgs: [cep.id]);
    return result;
  }

  Future<int> deleteCep(int cep) async {
    final Database _db = await data.db;
    final result = await _db.delete(DBTableName.ceps.value, where: 'CEP_ID = ?', whereArgs: [cep]);
    return result;
  }
}
