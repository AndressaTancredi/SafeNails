import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe_nails/common/common_strings.dart';

class FirebaseUtils {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<String?> createUser(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.updateDisplayName(name);
      return CommonStrings.success;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return CommonStrings.success;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> signOut() async {
    try {
      await firebaseAuth.signOut();
      return CommonStrings.success;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return CommonStrings.success;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      return CommonStrings.success;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
