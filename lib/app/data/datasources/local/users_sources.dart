


import '../../../core/models/user_model.dart';
import '../../../core/repositories/local_service.dart';
import '../../../core/services/database/database_sqlite.dart';

class UserSources extends LocalServiceRepo{

  Future<UserModel> signIn(String email, String pass) async {
    UserModel user;
    final Database _db = await data.db;
    final result = await _db.query(DBTableName.users.value,
        where: 'USR_EMAIL = ? and USR_SENHA = ?', whereArgs: [email, pass]);
    user = UserModel.fromMap(result.first);
    return user;
  }

  Future<int> signUp(UserModel user) async {
    final Database _db = await data.db;
    final result = await _db.insert(DBTableName.users.value, user.toMap() );
    return result;
  }
}
