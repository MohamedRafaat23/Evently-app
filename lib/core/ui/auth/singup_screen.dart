import 'package:event_app/core/ui/auth/login_screen.dart';
import 'package:event_app/core/ui/auth/validation/validation.dart';
import 'package:event_app/core/widgets/language_switch.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});
  static const String routeName = "Sign Up";

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}
class _SingupScreenState extends State<SingupScreen> {
  bool passwordVisibleOff = false;
  bool rePasswordVisibleOff = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var localization = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.register,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_evently.png",
                  width: MediaQuery.sizeOf(context).width * 0.3,
                ),
              ],
            ),
            SizedBox(height: height*0.01),
            TextFormField(
              controller: nameController,
              validator: AppValidator.validateName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: localization.name,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: height * 0.01),
            TextFormField(
              controller: mailController,
              validator:AppValidator.validateEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: localization.email,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: height * 0.01),
            TextFormField(
              controller: passwordController,
              validator: AppValidator.validatePassword,
              obscureText: passwordVisibleOff,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: localization.password,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisibleOff = !passwordVisibleOff;
                    });
                  },
                  child: Icon(
                    passwordVisibleOff
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            TextFormField(
              controller: repasswordController,
              validator: (value) => AppValidator.validateConfirmPassword(value, passwordController.text),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: rePasswordVisibleOff,
              decoration: InputDecoration(
                hintText: localization.rePassword,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      rePasswordVisibleOff = !rePasswordVisibleOff;
                    });
                  },
                  child: Icon(
                    rePasswordVisibleOff
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            FilledButton(
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  try {
                    await FirebaseAuthService.createUserWithEmailAndPassword(
                      password: passwordController.text,
                      email: mailController.text,
                      name: nameController.text,
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    rethrow;
                  }
                }
              },
              child: Text(localization.createAccount),
            ),
            SizedBox(height: height*0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localization.alreadyHaveAccount,
                  style: theme.textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text(
                    localization.login,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
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
