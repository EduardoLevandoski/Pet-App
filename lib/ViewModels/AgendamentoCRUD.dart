import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Agendamento.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class AgendamentoFB extends GetxController {
  static AgendamentoFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<void> criaAgendamentoFB({required Agendamento agendamento}) async {
    try {
      await _db.collection(ColecoesFB.agendamentos).add(agendamento.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Agendamento>> buscaAgendamentosPorUIDFB(String uid) async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.agendamentos)
          .where('uid', isEqualTo: uid)
          .get();
      return snapshot.docs.map((e) => Agendamento.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeAgendamentoPet({required int petId}) async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.agendamentos)
          .where("petId", isEqualTo: petId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
      }
    } catch (e) {
      print(e);
    }
  }
}