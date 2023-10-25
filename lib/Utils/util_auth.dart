import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService extends GetxController {
  static FirebaseAuthService get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  Future<User?> cadastroEmailSenha({required String email, required String password}) async {
    
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> loginEmailSenha({required String email, required String password}) async {

    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      rethrow;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
