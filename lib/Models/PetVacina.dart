import 'package:cloud_firestore/cloud_firestore.dart';

class PetVacina {
  int? id;
  int? idPet;
  int? idVacina;
  String? vacina;
  bool? concluida;
  DateTime? data;
  DateTime? dataRepetir;

  PetVacina({
    this.id,
    this.idPet,
    this.idVacina,
    this.vacina,
    this.concluida,
    this.data,
    this.dataRepetir,
  });

  factory PetVacina.fromJson(Map<String, dynamic> json) {
    return PetVacina(
      id: json["id"],
      idPet: json["idPet"],
      idVacina: json["idVacina"],
      vacina: json["vacina"],
      concluida: json["concluida"],
      data: json["data"],
      dataRepetir: json["dataRepetir"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idPet": idPet,
      "idVacina": idVacina,
      "vacina": vacina,
      "concluida": concluida,
      "data": data,
      "dataRepetir": dataRepetir,
    };
  }

  factory PetVacina.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return PetVacina(
      id: data["id"],
      idPet: data["idPet"],
      idVacina: data["idVacina"],
      vacina: data["vacina"],
      concluida: data["concluida"],
      data: data["data"]?.toDate(),
      dataRepetir: data["dataRepetir"]?.toDate(),
    );
  }
}
