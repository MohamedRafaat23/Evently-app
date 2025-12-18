import 'package:event_app/core/ui/auth/login_screen.dart';
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
  GlobalKey<FormState>formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style: Theme.of(context).textTheme.titleLarge,
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
            SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name is Required";
                } else if (!RegExp(r'^[a-zA-Z\s]{2,}$').hasMatch(value)) {
                  return "Entar  Valid Name";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.name,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: mailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is Required";
                } else if (!!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\$',
                ).hasMatch(value)) {
                  return "Please enter a valid email";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password ia Required";
                } else if (!RegExp(
                  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{5,}$',
                ).hasMatch(value)) {
                  return "Password at least 5 char,\n include a letter,\nnumber and special char";
                }
                return null;
              },
              obscureText: passwordVisibleOff,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisibleOff = !passwordVisibleOff;
                    });
                  },
                  child: Icon(
                    passwordVisibleOff ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: repasswordController,
              validator: (value) {
                if (value != passwordController.text) {
                  return "Password Doesn't Match";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: rePasswordVisibleOff,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.rePassword,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      rePasswordVisibleOff = !rePasswordVisibleOff;
                    });
                  },
                  child: Icon(
                    rePasswordVisibleOff ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            FilledButton(
              
              onPressed: () 
             async {
                if(formkey.currentState!.validate()){
                 try{
                   await FirebaseAuthService.createUserWithEmailAndPassword(password: passwordController.text, email: mailController.text, name: nameController.text);
                   Navigator.pop(context);
                 }catch(e){
                  print(e);
                 }
                }
               
              },
              child: Text(AppLocalizations.of(context)!.createAccount),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.alreadyHaveAccount,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: Theme.of(context).textTheme.titleMedium,
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
