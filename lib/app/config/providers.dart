

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/services/database/database_sqlite.dart';
import '../presentation/controllers/cep_controller.dart';
import '../presentation/controllers/user_controller.dart';

export 'package:provider/provider.dart';

class Providers {

  static List<SingleChildWidget> listDefault(){
    return [
      Provider(
        create: (_)=>  DatabaseSqlite(),
        lazy: false,
      ),
      ChangeNotifierProvider(
          create: (_)=>  UserController()
      ),
      ChangeNotifierProvider(
          create: (_)=>  CepController()
      ),
    ];
  }

  static List<DisposableProvider> _getDisposableProviders(BuildContext context) {
    return [
      Provider.of<UserController>(context, listen: false),
      Provider.of<CepController>(context, listen: false),

    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    _getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }

}

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}