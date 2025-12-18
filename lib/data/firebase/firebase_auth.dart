import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  // "instance" to create obj one time and reuse it exampted time counsuming
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

//create user with email and password
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
//sign with email and password
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

 static bool isInitialized = false;
  //initialize google sign in =>identify app in google
  static Future<void> _initializeSignInWithGoogle() async {
if( !isInitialized)
{
  await _googleSignIn.initialize(
    serverClientId: "872183862119-pnskm5d429rbpa2g4qp28rhulc51siar.apps.googleusercontent.com");
}
isInitialized=true;
  }
//user select account=> IDtoken , accessToken
 static Future<UserCredential>signInWithGoogle()async{
  _initializeSignInWithGoogle();
GoogleSignInAccount? account=await _googleSignIn.authenticate();
final idToken=account.authentication.idToken;
final authClien =account.authorizationClient;
GoogleSignInClientAuthorization ?auth=await authClien.authorizationForScopes(['email' , 'profile']);
final accessToken = auth?.accessToken;

//token sign in
final credential = GoogleAuthProvider.credential(
  idToken: idToken,
  accessToken: accessToken,
);
return await FirebaseAuth.instance.signInWithCredential(credential);
}

   static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
