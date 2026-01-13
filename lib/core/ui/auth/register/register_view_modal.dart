import 'package:event_app/core/ui/auth/register/register_navigator.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModal extends ChangeNotifier {
  RegisterNavigator? navigator;

  void register(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator?.goToLogin();
    } on FirebaseAuthException catch (e) {
      navigator?.showErrorDialog(e.message ?? "Something went wrong");
    } catch (e) {
      navigator?.showErrorDialog("Unexpected error occurred");
    }
  }
}
