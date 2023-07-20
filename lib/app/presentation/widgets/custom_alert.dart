
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'custom_buttom.dart';


class CustomAlert{

  static load(BuildContext context){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return  Center(child: CircularProgressIndicator(backgroundColor: Colors.transparent,),
          );
        }
    );
  }

}

