

import 'package:flutter/material.dart';

import '../../config/providers.dart';
import '../../core/models/user_model.dart';
import '../../data/datasources/local/users_sources.dart';

class UserController extends DisposableProvider {
  final UserSources _sources = UserSources();
  UserModel? user;


  Future<void> signIn(String email, String pass,) async {
    user = await _sources.signIn(email, pass);
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String pass) async {
    try {
      UserModel model = UserModel(usrName: name, usrEmail: email, usrSenha: pass);
      final result = await _sources.signUp(model);
      if(result > 0){
        model.usrId = result;
        user = model;
        notifyListeners();
      }else{
        throw result;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw 'Não foi possivel cadastrar seu usuario, verifique os dados e tente novamente!';
    }
  }

  @override
  void disposeValues() {
    user = null;
  }
}