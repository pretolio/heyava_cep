

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../config/theme_colors.dart';
import '../../utils/validations.dart';



class CustomTextFormField{

  static Widget custom({TextEditingController? controller, String? title, Widget? icon,
    void Function(String)? onFieldSubmitted, bool textAlign = false, bool isNext = false,
    bool isBorder = false, bool isClean = false, String? hintText, bool? obscureText,
    String? Function(String?)? validator, FormType type = FormType.text, TextInputType? keyboardType,
    double radius = 12, double? width, Color txtColor = Colors.black, bool enabled = true}){

    return ChangeNotifierProvider(
      create: (BuildContext context) => FormProvider(),
      child: Consumer<FormProvider>(
        builder: (context, form, __) {
          return SizedBox(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: textAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                if(title != null)
                Padding(
                  padding: EdgeInsets.only(left: 5, top: 5, bottom: textAlign ? 5:0),
                  child: Text(title, style: TextStyle(color: enabled ? txtColor : txtColor.withOpacity(0.3),
                      fontSize: textAlign ? 18:14, fontWeight: FontWeight.w600),),
                ),
                TextFormField(
                  controller: controller,
                  enabled: enabled,
                  style: TextStyle(fontSize: 12),
                  scrollPadding: EdgeInsets.zero,
                  onFieldSubmitted: onFieldSubmitted,
                  textInputAction: isNext ? TextInputAction.next : TextInputAction.done,
                  obscureText: obscureText ?? type == FormType.pass,
                  keyboardType: keyboardType ?? (type == FormType.text || type == FormType.pass ? TextInputType.text
                      : type == FormType.email ? TextInputType.emailAddress : TextInputType.number),
                  decoration: InputDecoration(
                    suffixIcon: icon ?? (!isClean ? null : IconButton(onPressed: (){
                      controller?.clear();
                    }, icon: Icon(Icons.clear, color: ThemeColors.priColor,))),
                    fillColor: form.isError ? Colors.red.shade100 : ThemeColors.priColor.withOpacity(0.05), filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    border: OutlineInputBorder(borderSide:
                        isBorder ? BorderSide(color: ThemeColors.priColor) : BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(radius))),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent.shade100),
                        borderRadius: BorderRadius.all(Radius.circular(radius))),
                    errorStyle: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 11, color: Colors.redAccent.shade100),
                    hintText: hintText ?? (
                        type == FormType.text ? 'Preencha ${title ?? 'campo'}'
                        : type == FormType.pass ? '********'
                        : type == FormType.email ? 'email@email.com'
                        : type == FormType.cep ? '00000-000' : null
                    ),
                    hintStyle: TextStyle(fontSize: 12),
                  ),

                  inputFormatters: type == FormType.cep ? [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ]  : null,
                  validator: validator ?? (type == FormType.cep ? (v){
                    if(v == null || v == ''){
                      form.isError = true;
                      return 'Digite o seu CEP';
                    }else if(v.length < 10){
                      form.isError = true;
                      return 'Digite o seu CEP';
                    }
                    form.isError = false;
                    return null;
                  }  : type == FormType.email ? (v){
                    if(v == null || v == ''){
                      form.isError = true;
                      return 'Digite seu email';
                    }else if(!Validations.emailValid(v)){
                      form.isError = true;
                      return 'Digite email valido!';
                    }
                    form.isError = false;
                    return null;
                  } : type == FormType.pass ? (v){
                    if(v == null || v == ''){
                      form.isError = true;
                      return 'Digite sua senha';
                    }
                    form.isError = false;
                    return null;
                  } : (v){
                    if(v == null || v == ''){
                      form.isError = true;
                      return 'Digite ${title ?? 'campo'}';
                    }
                    form.isError = false;
                    return null;
                  }),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class FormProvider extends ChangeNotifier {
  bool _isError = false;
  bool get isError => _isError;
  set isError(bool v){
    if(_isError != v){
      _isError = v;
      notifyListeners();
    }
  }
}

enum FormType {
  cep,
  email,
  pass,
  text;
}