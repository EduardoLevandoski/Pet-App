import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  int? id;
  String? uid;
  String? nome;
  DateTime? idade;
  String? sexo;
  String? especie;
  String? raca;
  double? peso;
  String? imgNome;
  String? imgUrl;

  Pet({
    this.id,
    this.uid,
    this.nome,
    this.idade,
    this.sexo,
    this.especie,
    this.raca,
    this.peso,
    this.imgNome,
    this.imgUrl,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json["id"],
      uid: json["uid"],
      nome: json["nome"],
      idade: json["idade"],
      sexo: json["sexo"],
      especie: json["especie"],
      raca: json["raca"],
      peso: json["peso"],
      imgNome: json["imgNome"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "nome": nome,
      "idade": idade,
      "sexo": sexo,
      "especie": especie,
      "raca": raca,
      "peso": peso,
      "imgNome": imgNome,
    };
  }

  factory Pet.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Pet(
      id: data["id"],
      uid: data["uid"],
      nome: data["nome"],
      idade: data["idade"]?.toDate(),
      sexo: data["sexo"],
      especie: data["especie"],
      raca: data["raca"],
      peso: data["peso"],
      imgNome: data["imgNome"],
    );
  }
}
