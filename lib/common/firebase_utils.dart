import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/remote_config_service.dart';
import 'package:safe_nails/firebase_options.dart';

class FirebaseUtils {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static bool isAllowedUser(String email) {
    final allowedUsersString = sl<RemoteConfig>().getValue('allowedUsers');
    if (allowedUsersString.contains(email)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> createUser(
      String name, String email, String password) async {
    try {
      if (isAllowedUser(email) == true) {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        userCredential.user!.updateDisplayName(name);
        return "Success";
      } else {
        return "user_not_allowed";
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      if (isAllowedUser(email) == true) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return "Success";
      } else {
        return "user_not_allowed";
      }
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
      if (isAllowedUser(email) == true) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        return "Success";
      } else {
        return "user_not_allowed";
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> deleteUser() async {
    try {
      print(FirebaseAuth.instance.currentUser!);
      await FirebaseAuth.instance.currentUser!.delete();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
