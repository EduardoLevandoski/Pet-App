import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/PetParasitas.dart';
import 'package:pet_app/Models/PetVacina.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class PetParasitaFB extends GetxController {
  static PetParasitaFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<PetParasita>> buscaPetsParasitasFB({required int idPet}) async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.petparasitas)
          .where("idPet", isEqualTo: idPet)
          .get();
      return snapshot.docs.map((e) => PetParasita.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
