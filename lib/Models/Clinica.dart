import 'package:cloud_firestore/cloud_firestore.dart';

class Clinica {
  int? id;
  int? idClinica;
  String? razaoSocial;
  String? nomeFantasia;
  String? endereco;
  String? endBairro;
  String? endNumero;
  String? endComplemento;
  String? endCep;
  String? telefone;

  Clinica({
    this.id,
    this.idClinica,
    this.razaoSocial,
    this.nomeFantasia,
    this.endereco,
    this.endBairro,
    this.endNumero,
    this.endComplemento,
    this.endCep,
    this.telefone,
  });

  factory Clinica.fromJson(Map<String, dynamic> json) {
    return Clinica(
      id: json["id"],
      idClinica: json["idClinica"],
      razaoSocial: json["razaoSocial"],
      nomeFantasia: json["nomeFantasia"],
      endereco: json["endereco"],
      endBairro: json["endBairro"],
      endNumero: json["endNumero"],
      endComplemento: json["endComplemento"],
      endCep: json["endCep"],
      telefone: json["telefone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idClinica": idClinica,
      "razaoSocial": razaoSocial,
      "nomeFantasia": nomeFantasia,
      "endereco": endereco,
      "endBairro": endBairro,
      "endNumero": endNumero,
      "endComplemento": endComplemento,
      "endCep": endCep,
      "telefone": telefone,
    };
  }

  factory Clinica.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Clinica(
      id: data["id"],
      idClinica: data["idClinica"],
      razaoSocial: data["razaoSocial"],
      nomeFantasia: data["nomeFantasia"],
      endereco: data["endereco"],
      endBairro: data["endBairro"],
      endNumero: data["endNumero"],
      endComplemento: data["endComplemento"],
      endCep: data["endCep"],
      telefone: data["telefone"],
    );
  }
}
