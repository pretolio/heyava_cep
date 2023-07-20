
import 'package:flutter/material.dart';

import '../core/models/cep_model.dart';
import '../presentation/views/cep_view.dart';
import '../presentation/views/home_view.dart';
import '../presentation/views/login_view.dart';

enum Routes {
  login('/login'),
  home('/home'),
  cep('/cep');

  final String value;
  const Routes(this.value);


  void pushNamed(BuildContext context, {Object? arguments}){
    Navigator.pushNamed(context, value, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(BuildContext context){
    Navigator.pushNamedAndRemoveUntil(context,value, (route) => false);
  }

  static Routes stringToRoute(String? v){
    Routes rote = Routes.login;
    if(Routes.values.any((e) => e.value == v)){
      rote = Routes.values.firstWhere((e) => e.value == v);
    }
    return rote;
  }

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch (Routes.stringToRoute(settings.name)) {
      case Routes.login :
        return MaterialPageRoute(
            builder: (_) => const LoginView()
        );
      case Routes.home :
        return MaterialPageRoute(
            builder: (_) => const HomeView()
        );
      case Routes.cep :
        CepModel? arg = settings.arguments as CepModel?;
        return MaterialPageRoute(
            builder: (_) => CepView(arg)
        );
    }
  }
}