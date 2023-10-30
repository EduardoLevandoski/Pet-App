import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class PetFB extends GetxController {
  static PetFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<void> criaPetFB({required Pet pet}) async {
    try {
      await _db.collection(ColecoesFB.pets).add(pet.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editaPet({required int id, required Pet pet}) async {
    try {
      final query = await _db
          .collection(ColecoesFB.pets)
          .where("id", isEqualTo: id)
          .get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.update(pet.toJson());
      } else {
        throw Exception("Não foi possivel encontrar o pet");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Pet>> buscaPetsPorUIDFB({required String idUsuario}) async {
    try {
      final snapshot = await _db.collection(ColecoesFB.pets).where("uid", isEqualTo: idUsuario).get();
      return snapshot.docs.map((e) => Pet.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
