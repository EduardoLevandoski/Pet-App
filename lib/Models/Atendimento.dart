import 'package:cloud_firestore/cloud_firestore.dart';

class Atendimento {
  int? id;
  int? idPet;
  int? idVacina;
  int? tipo;
  String? vacina;
  String? medicamento;
  double? peso;
  bool? concluida;
  DateTime? data;
  DateTime? dataRepetir;

  Atendimento({
    this.id,
    this.idPet,
    this.idVacina,
    this.tipo,
    this.vacina,
    this.medicamento,
    this.peso,
    this.concluida,
    this.data,
    this.dataRepetir,
  });

  factory Atendimento.fromJson(Map<String, dynamic> json) {
    return Atendimento(
      id: json["id"],
      idPet: json["idPet"],
      idVacina: json["idVacina"],
      tipo: json["tipo"],
      vacina: json["vacina"],
      medicamento: json["medicamento"],
      peso: json["peso"],
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
      "tipo": tipo,
      "vacina": vacina,
      "medicamento": medicamento,
      "peso": peso,
      "concluida": concluida,
      "data": data,
      "dataRepetir": dataRepetir,
    };
  }

  factory Atendimento.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Atendimento(
      id: data["id"],
      idPet: data["idPet"],
      idVacina: data["idVacina"],
      tipo: data["tipo"],
      vacina: data["vacina"],
      medicamento: data["medicamento"],
      peso: data["peso"] != null ? double.tryParse(data["peso"].toString()) : null,
      concluida: data["concluida"],
      data: data["data"]?.toDate(),
      dataRepetir: data["dataRepetir"]?.toDate(),
    );
  }
}
