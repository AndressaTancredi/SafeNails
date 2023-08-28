import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safe_nails/firebase_options.dart';

class FirebaseUtils {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<String?> createUser(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.updateDisplayName(name);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> signOut() async {
    try {
      await firebaseAuth.signOut();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // static Future<String> changePassword(
  //     String currentPassword, String newPassword) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser!;
  //     final cred = EmailAuthProvider.credential(
  //         email: user.email!, password: currentPassword);
  //     user.reauthenticateWithCredential(cred).then((value) async {
  //       await user.updatePassword(newPassword);
  //     });
  //     return "Success";
  //   } on FirebaseAuthException catch (e) {
  //     return e.code;
  //   }
  // }
}
