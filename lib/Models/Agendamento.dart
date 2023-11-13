import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/Models/Pet.dart';

class Agendamento{
  int? id;
  String? uid;
  int? petId;
  String? clinicaNome;
  String? servicoDesc;
  DateTime? data;
  Pet? pet;

  Agendamento({
    this.id,
    this.uid,
    this.petId,
    this.clinicaNome,
    this.servicoDesc,
    this.data,
    this.pet,
  });

  factory Agendamento.fromJson(Map<String, dynamic> json) {
    return Agendamento(
      id: json["id"],
      uid: json["uid"],
      petId: json["petId"],
      clinicaNome: json["clinicaNome"],
      servicoDesc: json["servicoDesc"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "petId": petId,
      "clinicaNome": clinicaNome,
      "servicoDesc": servicoDesc,
      "data": data,
    };
  }

  factory Agendamento.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Agendamento(
      id: data["id"],
      uid: data["uid"],
      petId: data["petId"],
      clinicaNome: data["clinicaNome"],
      servicoDesc: data["servicoDesc"],
      data: data["data"]?.toDate(),
    );
  }
}