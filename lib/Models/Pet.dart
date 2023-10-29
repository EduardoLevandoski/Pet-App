import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  String? uid;
  String? nome;
  DateTime? idade;
  String? sexo;
  String? especie;
  String? raca;
  String? peso;
  String? cor;
  String? imgNome;
  String? imgUrl;

  Pet({
    this.uid,
    this.nome,
    this.idade,
    this.sexo,
    this.especie,
    this.raca,
    this.peso,
    this.cor,
    this.imgNome,
    this.imgUrl,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      uid: json["uid"],
      nome: json["nome"],
      idade: json["idade"],
      sexo: json["sexo"],
      especie: json["especie"],
      raca: json["raca"],
      peso: json["peso"],
      cor: json["cor"],
      imgNome: json["imgNome"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "nome": nome,
      "idade": idade,
      "sexo": sexo,
      "especie": especie,
      "raca": raca,
      "peso": peso,
      "cor": cor,
      "imgNome": imgNome,
    };
  }

  factory Pet.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Pet(
      uid: data["uid"],
      nome: data["nome"],
      idade: data["idade"]?.toDate(),
      sexo: data["sexo"],
      especie: data["especie"],
      raca: data["raca"],
      peso: data["peso"],
      cor: data["cor"],
      imgNome: data["imgNome"],
    );
  }
}
