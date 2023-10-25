import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? uid;
  String? nome;
  String? email;
  String? cpf;

  Usuario({
    this.uid,
    this.nome,
    this.email,
    this.cpf,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json["uid"],
      nome: json["nome"],
      email: json["email"],
      cpf: json["cpf"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "nome": nome,
      "email": email,
      "cpf": cpf,
    };
  }

  factory Usuario.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Usuario(
      uid: data["uid"],
      nome: data["nome"],
      email: data["email"],
      cpf: data["cpf"],
    );
  }
}
