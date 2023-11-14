import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/Models/Pet.dart';

class Agendamento{
  int? id;
  String? uid;
  int? idAtendimento;
  int? idPet;
  String? clinicaNome;
  String? servicoDesc;
  DateTime? data;
  Pet? pet;

  ///Status 0: Em andamento, Status 1: Conclúido, Status 2: Aguardando horário, Status 3: Aguardando pet, Status 4: Aguardando dono, Status 5: Cancelado
  int? status;

  Agendamento({
    this.id,
    this.uid,
    this.idAtendimento,
    this.idPet,
    this.clinicaNome,
    this.servicoDesc,
    this.data,
    this.status,
    this.pet,
  });

  factory Agendamento.fromJson(Map<String, dynamic> json) {
    return Agendamento(
      id: json["id"],
      uid: json["uid"],
      idAtendimento: json["idAtendimento"],
      idPet: json["petId"],
      clinicaNome: json["clinicaNome"],
      servicoDesc: json["servicoDesc"],
      data: json["data"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "idAtendimento": idAtendimento,
      "petId": idPet,
      "clinicaNome": clinicaNome,
      "servicoDesc": servicoDesc,
      "data": data,
      "status": status,
    };
  }

  factory Agendamento.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Agendamento(
      id: data["id"],
      uid: data["uid"],
      idAtendimento: data["idAtendimento"],
      idPet: data["petId"],
      clinicaNome: data["clinicaNome"],
      servicoDesc: data["servicoDesc"],
      data: data["data"]?.toDate(),
      status: data["status"],
    );
  }
}