import 'package:cloud_firestore/cloud_firestore.dart';

class Atendimento {
  int? id;
  int? idPet;
  int? idVacina;
  int? tipo;
  String? vacina;
  String? medicamento;
  double? peso;
  DateTime? data;
  DateTime? dataRepetir;
  String? servico;

  ///Status 0: Em andamento, Status 1: Conclúido, Status 2: Aguardando horário, Status 3: Aguardando pet, Status 4: Aguardando dono, Status 5: Cancelado
  int? status;

  Atendimento({
    this.id,
    this.idPet,
    this.idVacina,
    this.tipo,
    this.vacina,
    this.medicamento,
    this.peso,
    this.status,
    this.data,
    this.dataRepetir,
    this.servico,
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
      status: json["status"],
      data: json["data"],
      dataRepetir: json["dataRepetir"],
      servico: json["servico"],
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
      "status": status,
      "data": data,
      "dataRepetir": dataRepetir,
      "servico": servico,
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
      status: data["status"],
      data: data["data"]?.toDate(),
      dataRepetir: data["dataRepetir"]?.toDate(),
      servico: data["servico"],
    );
  }
}
