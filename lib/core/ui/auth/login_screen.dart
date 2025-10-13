import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/core/ui/auth/forget_password_screen.dart';
import 'package:event_app/core/ui/auth/singup_screen.dart';
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
   bool passwordVisible=false;
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  GlobalKey<FormState>formkey=GlobalKey< FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 16,),
            TextFormField(
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
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  // } else if (!RegExp(
                  //   r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{5,}$',
                  // ).hasMatch(value)) {
                  //   return "Password at least 5 char,\n include a letter,\nnumber and special char";
                  }
                  return null;
                },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.password,
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
                    Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.purple),
                  ),
                ),
              ],
            ),
            FilledButton(onPressed: ()async{
              if(formkey.currentState!.validate()){
                //try to sign in if you couldn't sign catch e 
               try{
                 await FirebaseAuthService.signInWithEmailAndPassword(password:passwordController.text , email: emailController.text);
                 Navigator.pushReplacementNamed(context, HomeScreen.routeName);
               }catch(e){
                print(e);
               }
              }
              
        
            }, child: Text(AppLocalizations.of(context)!.login)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(AppLocalizations.of(context)!.dontHaveAccount, style: Theme.of(context).textTheme.bodyLarge,),
                 TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SingupScreen.routeName);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.createAccount,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.purple),
                  ),
                ),
            ],),
            Row(children: [
            Expanded(child: Divider(color: Theme.of(context).colorScheme.primary,)),
            SizedBox(width: 20,),
            Text(AppLocalizations.of(context)!.or , style: Theme.of(context).textTheme.bodyMedium,),
              SizedBox(width: 20,),
             Expanded(child: Divider(color: Theme.of(context).colorScheme.primary,)),
        
            ],),
            SizedBox(height: 16,),
            OutlinedButton(onPressed: (){
              try{
                FirebaseAuthService.signInWithGoogle();
              }catch(e){
                print(e.toString());
              }
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
              // Image.asset("assets/images/google icon.png"),
              SizedBox(width: 15,),
        
             Text(AppLocalizations.of(context)!.dontHaveAccount, style: Theme.of(context).textTheme.titleMedium,),
            ],),
            
            ),
             Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
            LangSwitch()
          ],),
        )
          ],
        ),
      ),
    );
  }
}
