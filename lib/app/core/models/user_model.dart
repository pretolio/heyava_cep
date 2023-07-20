
// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

class UserModel {
  int? usrId;
  String? usrName;
  String? usrEmail;
  String? usrSenha;

  UserModel({
    this.usrId,
    this.usrName,
    this.usrEmail,
    this.usrSenha,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    usrId: json["USR_ID"],
    usrName: json["USR_NAME"],
    usrEmail: json["USR_EMAIL"],
    usrSenha: json["USR_SENHA"],
  );

  Map<String, dynamic> toMap() => {
    "USR_NAME": usrName,
    "USR_EMAIL": usrEmail,
    "USR_SENHA": usrSenha,
  };
}
