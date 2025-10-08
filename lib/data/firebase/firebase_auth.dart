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

//  static Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // 1- فتح نافذة اختيار حساب Google

//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) return null;
//       // 2- جلب التوكين
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       // 3- إنشاء credential من Google
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
      
//       return await firebaseAuth.signInWithCredential(credential);
//     } catch (e) {
//       print("Google Sign-In error: $e");
//     }
//   }

   static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
