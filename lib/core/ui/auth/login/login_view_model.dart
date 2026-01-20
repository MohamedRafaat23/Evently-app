import 'package:event_app/core/ui/auth/login/login_navigator.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier{
  late LoginNavigator loginNavigator;
  void login(String email , String password)async{
   try{
  await FirebaseAuthService.signInWithEmailAndPassword(password: password, email: email);
  loginNavigator.goToHome();
}on FirebaseAuthException catch (e) {
      loginNavigator.showErrorDialog(e.message ?? "Something went wrong");
    } catch (e) {
      loginNavigator.showErrorDialog("Unexpected error occurred");
    }
  }
}