import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Clinica.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class ClinicaFB extends GetxController {
  static ClinicaFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<Clinica>> buscaClinicasFB() async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.clinicas).get();
      return snapshot.docs.map((e) => Clinica.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
