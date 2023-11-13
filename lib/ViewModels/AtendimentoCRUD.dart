import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Atendimento.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class AtendimentoFB extends GetxController {
  static AtendimentoFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;


  Future<List<Atendimento>> buscaPetVacinasFB({required int idPet}) async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.atendimentos)
          .where("idPet", isEqualTo: idPet).where("tipo", isEqualTo: 1)
          .get();
      return snapshot.docs.map((e) => Atendimento.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Atendimento>> buscaPetParasitasFB({required int idPet}) async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.atendimentos)
          .where("idPet", isEqualTo: idPet).where("tipo", isEqualTo: 2)
          .get();
      return snapshot.docs.map((e) => Atendimento.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Atendimento>> buscaPetAtendimentoFB({required int idPet}) async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.atendimentos)
          .where("idPet", isEqualTo: idPet).where("tipo", isGreaterThan: 2)
          .get();
      return snapshot.docs.map((e) => Atendimento.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
