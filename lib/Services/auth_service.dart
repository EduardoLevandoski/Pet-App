import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService extends GetxController {
  static FirebaseAuthService get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  Future getUsuarioAtual() async {
    return _auth.currentUser;
  }

  Future<User?> cadastroEmailSenha({required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleAuthException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> loginEmailSenha({required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.generateErrorMessage(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthStatus> resetaSenha({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleAuthException(e);
    } catch (e) {
      rethrow;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Your password should be at least 6 characters.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your email or password is wrong.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage = "The email address is already in use by another account.";
        break;
      default:
        errorMessage = "An error occured. Please try again later.";
    }
    return errorMessage;
  }
}
