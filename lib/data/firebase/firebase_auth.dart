import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static User? getUserData(){
    return firebaseAuth.currentUser;
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

static Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(idToken: googleAuth?.idToken);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

   static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
