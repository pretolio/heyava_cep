// To parse this JSON data, do
//
//     final cepModel = cepModelFromMap(jsonString);

import 'dart:convert';

import '../../utils/validations.dart';


class CepModel {
  int? id;
  int? idUser;
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;

  CepModel({
    this.id,
    this.idUser,
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  factory CepModel.fromMapLocal(Map<String, dynamic> json) => CepModel(
    id: json["CEP_ID"],
    idUser: json["CEP_USR_ID"],
    cep: Validations.maskCep(json["CEP_NUM"]),
    logradouro: json["CEP_LOGRADOURO"],
    complemento: json["CEP_COMPLENTO"],
    bairro: json["CEP_BAIRRO"],
    localidade: json["CEP_LOCALIDADE"],
    uf: json["CEP_UF"],
    ibge: json["CEP_IBGE"],
    gia: json["CEP_GIA"],
    ddd: json["CEP_DDD"],
    siafi: json["CEP_SIAFI"],
  );

  factory CepModel.fromMapRemote(Map<String, dynamic> json) => CepModel(
    cep: Validations.maskCep(json["cep"]),
    logradouro: json["logradouro"],
    complemento: json["complemento"],
    bairro: json["bairro"],
    localidade: json["localidade"],
    uf: json["uf"],
    ibge: json["ibge"],
    gia: json["gia"],
    ddd: json["ddd"],
    siafi: json["siafi"],
  );

  Map<String, dynamic> toMapInsert() => {
    "CEP_USR_ID": idUser,
    "CEP_NUM": cep,
    "CEP_LOGRADOURO": logradouro,
    "CEP_COMPLENTO": complemento,
    "CEP_BAIRRO": bairro,
    "CEP_LOCALIDADE": localidade,
    "CEP_UF": uf,
    "CEP_IBGE": ibge,
    "CEP_GIA": gia,
    "CEP_DDD": ddd,
    "CEP_SIAFI": siafi,
  };

  Map<String, dynamic> toMapUpdate() => {
    "CEP_NUM": cep,
    "CEP_LOGRADOURO": logradouro,
    "CEP_COMPLENTO": complemento,
    "CEP_BAIRRO": bairro,
    "CEP_LOCALIDADE": localidade,
    "CEP_UF": uf,
    "CEP_IBGE": ibge,
    "CEP_GIA": gia,
    "CEP_DDD": ddd,
    "CEP_SIAFI": siafi,
  };
}
