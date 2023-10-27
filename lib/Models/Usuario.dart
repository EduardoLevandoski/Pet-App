import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? uid;
  String? nome;
  String? email;
  String? cpf;
  String? imgNome;
  String? imgUrl;

  Usuario({
    this.uid,
    this.nome,
    this.email,
    this.cpf,
    this.imgNome,
    this.imgUrl,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json["uid"],
      nome: json["nome"],
      email: json["email"],
      cpf: json["cpf"],
      imgNome: json["imgNome"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "nome": nome,
      "email": email,
      "cpf": cpf,
      "imgNome": imgNome,
    };
  }

  factory Usuario.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Usuario(
      uid: data["uid"],
      nome: data["nome"],
      email: data["email"],
      cpf: data["cpf"],
      imgNome: data["imgNome"],
    );
  }
}
