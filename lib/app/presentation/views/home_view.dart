
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/providers.dart';
import '../../config/routes.dart';
import '../../config/theme_colors.dart';
import '../controllers/cep_controller.dart';
import '../controllers/user_controller.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    context.read<CepController>().getListCep(
        context.read<UserController>().user?.usrId ?? 0
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CepController>(
      builder: (_, controller,__) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Meus Ceps'),
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/img/logo_white.png',),
            ),
            actions: [
              IconButton(onPressed: (){
                Providers.listDefault();
                Routes.login.pushNamedAndRemoveUntil(context);
              }, icon: Icon(Icons.logout_sharp))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: controller.listCeps.map(
                  (e) => InkWell(
                    child: Card(
                      child: ListTile(
                        title: Text(e.cep ?? ''),
                        subtitle: Text(e.logradouro ?? ''),
                        leading: Icon(CupertinoIcons.map, size: 30, color: ThemeColors.priColor,),
                        trailing: Text(e.uf?.toUpperCase() ?? '', style: TextStyle(fontSize: 18),),
                      ),
                    ),
                    onTap: (){
                      Routes.cep.pushNamed(context, arguments: e);
                    },
                  )
              ).toList(),
            ),
          ),

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white,),
            shape: const CircleBorder(),
            onPressed: () {
              Routes.cep.pushNamed(context);
            },
          ),
        );
      }
    );
  }
}
