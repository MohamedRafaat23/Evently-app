

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
        });}
        

  static Future<void>signInWithEmailAndPassword({ required String password,
    required String email,})async{
   await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}
