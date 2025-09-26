import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  // "instance" to create obj one time and reuse it exampted time counsuming
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Future<void> createUserWithEmailAndPassword({
    required String password,
    required String email,
    required String name,
  }) async {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          await value.user?.updateDisplayName(name);
        });
  }

  static Future<UserCredential> signInWithEmailAndPassword({
    required String password,
    required String email,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
    ActionCodeSettings(
      url: 'https://evently-c16.web.app',
      handleCodeInApp: true,
      androidPackageName: 'com.example.event_app',
    );
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
