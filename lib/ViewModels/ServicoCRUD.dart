import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Servico.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class ServicoFB extends GetxController {
  static ServicoFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<Servico>> buscaServicosPorClinicaFB(int idClinica) async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.servicos)
          .where('idClinica', isEqualTo: idClinica)
          .get();
      return snapshot.docs.map((e) => Servico.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}