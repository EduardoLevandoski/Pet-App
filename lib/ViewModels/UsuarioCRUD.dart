import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Usuario.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class UsuarioFB extends GetxController {
  static UsuarioFB get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<void> criaUsuarioFB({required Usuario usuario}) async {
    try {
      await _db.collection(ColecoesFB.usuarios).add(usuario.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editaUsuarioFB({required String uidUsuario, String? novoNome, String? novoImgNome}) async {
    try {
      final query = await _db.collection(ColecoesFB.usuarios).where("uid", isEqualTo: uidUsuario).get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.update({
          "nome": novoNome,
          "imgNome": novoImgNome,
        });
      } else {
        throw Exception("Não foi possivel encontrar o usuário");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Usuario?> buscaUsuarioPorIdFB({required String idUsuario}) async {
    try {
      final snapshot = await _db.collection(ColecoesFB.usuarios).where("uid", isEqualTo: idUsuario).get();
      return snapshot.docs.map((e) => Usuario.fromSnapshot(e)).singleOrNull;
    } catch (e) {
      rethrow;
    }
  }
}
