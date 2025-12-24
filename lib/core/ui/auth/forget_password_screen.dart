import 'package:event_app/core/ui/auth/login_screen.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';

import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName = "Forget screen";
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  Future<void> resetPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.enterEmail)),
      );
      return;
    }
    try {
      //sending firebase email(reset password)
      await FirebaseAuthService.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.resetLinkSent)),
      );
      // رجع المستخدم لشاشة اللوجين بعد ما يوصله اللينك
      Navigator.pushNamed(context, LoginScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${AppLocalizations.of(context)!.error}: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var localization = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.forgotPassword,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/Group.png"),
                SizedBox(height: height * 0.02),
                TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: localization.enterEmail,
                  ),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: resetPassword,
                    child: Text(localization.resetPassword),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
