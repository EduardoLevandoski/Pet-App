import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Usuario.dart';

class UsuarioFB extends GetxController {
  static UsuarioFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<void> criaUsuarioFB({required Usuario usuario}) async {
    try {
      await _db.collection("usuarios").add(usuario.toJson());
    } catch (e) {
      rethrow;
    }
  }
  
  Future<Usuario?> buscaUsuarioPorIdFB({required String idUsuario}) async {
    try{
      final snapshot = await _db.collection("usuarios").where("uid", isEqualTo: idUsuario).get();
      return snapshot.docs.map((e) => Usuario.fromSnapshot(e)).singleOrNull;
    } catch (e) {
      rethrow;
    }
  }
}

