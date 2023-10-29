import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseStorageService extends GetxController {
  static FirebaseStorageService get instance => Get.find();
  final _storage = FirebaseStorage.instance;

  Future<void> enviaArquivo({required String filePath, required String fileNome, required String nomeStorageFB}) async {
    File file = File(filePath);

    try {
      await _storage.ref("$nomeStorageFB$fileNome").putFile(file);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> downloadURL({required String fileNome, required String nomeStorageFB}) async {
    try {
      return await FirebaseStorage.instance.ref(nomeStorageFB).child(fileNome).getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
