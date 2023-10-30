import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/PetVacina.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class PetVacinaFB extends GetxController {
  static PetVacinaFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<PetVacina>> buscaPetsVacinasFB({required int idPet}) async {
    try {
      final snapshot = await _db
          .collection(ColecoesFB.petvacinas)
          .where("idPet", isEqualTo: idPet)
          .get();
      return snapshot.docs.map((e) => PetVacina.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
