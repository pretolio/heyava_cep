import 'dart:convert';
import 'dart:core';

import 'package:brasil_fields/brasil_fields.dart';


class Validations {
  static final RegExp _numeric = RegExp(r'^-?[0-9]+$');

  static bool emailValid(String email){
    final RegExp regex = RegExp(
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
    return regex.hasMatch(email.trim().replaceAll(' ', ''));
  }

  /// check if the string contains only numbers
  static String onlyNumbers(String? str) {
    if(str == null) return '';
    return str.replaceAll(RegExp('[^0-9]'), '');
  }

  static String maskCep(String? str) {
    if(str == null || !isNumeric(onlyNumbers(str))) return '';
    return UtilBrasilFields.obterCep(onlyNumbers(str));
  }

  static String onlyLetters(String str) {
    String regex = r'[^\p{Mark}\p{Control}\p{Modifier_Letter}\p{Other_Letter}\p{Alphabetic}\p{Connector_Punctuation}\p{Join_Control}\s]+';
    return str.replaceAll(RegExp(regex, unicode: true), '');
  }

  /// check if the string contains only numbers
  static bool isNumeric(String str) {
    return _numeric.hasMatch(str);
  }
}