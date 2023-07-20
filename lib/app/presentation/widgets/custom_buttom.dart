

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/theme_colors.dart';


class CustomButtom {

  static Widget custom({required String title, Function? onPressed, double? height,
    bool expand = false, Color? color, Color? borderColor, IconData? icon,
    double? width, TextStyle? style, double radius = 25,}){


    return ChangeNotifierProvider(
      create: (BuildContext context) => CustomButtomController(),
      child: Consumer<CustomButtomController>(
          builder: (context, button, __) {
          return ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) => states.any((e) =>
                        e == MaterialState.disabled || e == MaterialState.error)
                          ? (color ?? ThemeColors.secColor).withOpacity(0.5) : color ?? ThemeColors.secColor ,
                ),
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
                      (Set<MaterialState> states) => const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                ),
                shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder?>(
                      (Set<MaterialState> states) => RoundedRectangleBorder(
                          side: BorderSide(color: borderColor ?? Colors.transparent), //the outline color
                          borderRadius: BorderRadius.all(Radius.circular(radius))),
                ),
                minimumSize: MaterialStateProperty.resolveWith<Size?>(
                      (Set<MaterialState> states) => const Size(0,0),
                ),
              ),
              onPressed: button.isLoad ? null : () async {
                try {
                  button.isLoad = true;
                  if(onPressed != null ) {
                    await onPressed();
                  }
                } finally {
                  button.isLoad = false;
                }
              },
              child: Shimmer.fromColors(
                baseColor: button.isLoad ? Colors.grey.shade100 :
                  color == Colors.white ? ThemeColors.secColor : Colors.white,
                highlightColor: button.isLoad ? Colors.grey.shade300 :
                  color == Colors.white ? ThemeColors.secColor : Colors.white ,
                enabled: button.isLoad,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Row(
                    mainAxisSize: expand ? MainAxisSize.max:  MainAxisSize.min,
                    mainAxisAlignment: width!= null && icon != null
                        ? MainAxisAlignment.start : MainAxisAlignment.center,
                    children:  [
                      if(icon != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: (title != '' ? 0 : 10)),
                          child: Icon(icon, size: 20, color: color == Colors.white
                              ? ThemeColors.secColor : Colors.white,),
                        ),
                      if(icon != null && title != '')
                        SizedBox(width: 10,),
                      if(title != '')
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: (icon != null || width!= null ? 0 : 10)),
                          child: Text(title, textAlign: TextAlign.center,
                            style: style ?? TextStyle(fontSize: 18,
                              color: color == Colors.white ? ThemeColors.secColor : Colors.white,

                            ),
                          ),
                        )
                    ],
                  ),
                ),
              )
          );
        }
      ),
    );
  }
}

class CustomButtomController extends ChangeNotifier{
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  set isLoad(bool v){
    _isLoad = v;
    notifyListeners();
  }
}
