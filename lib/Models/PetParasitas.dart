import 'package:cloud_firestore/cloud_firestore.dart';

class PetParasita {
  int? id;
  int? idPet;
  int? idMedicamento;
  String? medicamento;
  bool? concluida;
  double? peso;
  DateTime? data;
  DateTime? dataRepetir;

  PetParasita({
    this.id,
    this.idPet,
    this.idMedicamento,
    this.medicamento,
    this.concluida,
    this.peso,
    this.data,
    this.dataRepetir,
  });

  factory PetParasita.fromJson(Map<String, dynamic> json) {
    return PetParasita(
      id: json["id"],
      idPet: json["idPet"],
      idMedicamento: json["idMedicamento"],
      medicamento: json["medicamento"],
      concluida: json["concluida"],
      peso: json["peso"],
      data: json["data"],
      dataRepetir: json["dataRepetir"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idPet": idPet,
      "idMedicamento": idMedicamento,
      "medicamento": medicamento,
      "concluida": concluida,
      "peso": peso,
      "data": data,
      "dataRepetir": dataRepetir,
    };
  }

  factory PetParasita.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return PetParasita(
      id: data["id"],
      idPet: data["idPet"],
      idMedicamento: data["idMedicamento"],
      medicamento: data["medicamento"],
      concluida: data["concluida"],
      peso: double.tryParse(data["peso"].toString()),
      data: data["data"]?.toDate(),
      dataRepetir: data["dataRepetir"]?.toDate(),
    );
  }
}
