import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/core/ui/auth/forget_password_screen.dart';
import 'package:event_app/core/ui/auth/singup_screen.dart';
import 'package:event_app/core/ui/auth/validation/validation.dart';
import 'package:event_app/core/ui/home/home_screen.dart';
import 'package:event_app/core/widgets/language_switch.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "logonScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var localization = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_evently.png",
                  width: MediaQuery.sizeOf(context).width * 0.3,
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            TextFormField(
              validator: AppValidator.validateEmail,
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: localization.email,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: height * 0.01),
            TextFormField(
              validator: AppValidator.validatePassword,
              obscureText: !passwordVisible,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: localization.password,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ForgetPasswordScreen.routeName,
                    );
                  },
                  child: Text(
                    localization.forgotPassword,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.purple,
                    ),
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  //try to sign in if you couldn't sign catch e
                  try {
                    await FirebaseAuthService.signInWithEmailAndPassword(
                      password: passwordController.text,
                      email: emailController.text,
                    );
                    Navigator.pushReplacementNamed(
                      context,
                      HomeScreen.routeName,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              },
              child: Text(localization.login),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localization.dontHaveAccount,
                  style: theme.textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SingupScreen.routeName);
                  },
                  child: Text(
                    localization.createAccount,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.purple,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Divider(color: theme.colorScheme.primary)),
                SizedBox(width: width * 0.01),
                Text(localization.or, style: theme.textTheme.bodyMedium),
                SizedBox(width: width * 0.02),
                Expanded(child: Divider(color: theme.colorScheme.primary)),
              ],
            ),
            SizedBox(height: height * 0.01),
            OutlinedButton(
              onPressed: () {
                try {
                  FirebaseAuthService.signInWithGoogle();
                } catch (e) {
                  rethrow;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: width * 0.01),
                  Text(
                    localization.dontHaveAccount,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LangSwitch()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
