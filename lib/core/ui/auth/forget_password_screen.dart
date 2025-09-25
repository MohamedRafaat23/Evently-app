import 'package:event_app/core/ui/auth/login_screen.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName="Forget screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.forgotPassword, style: Theme.of(context).textTheme.titleLarge),),
    body:Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
        Image.asset("assets/images/change-setting.png"),
        SizedBox(height: 16,),
        FilledButton(onPressed: (){Navigator.pushNamed(context, LoginScreen.routeName);} ,child: Text(AppLocalizations.of(context)!.resetPassword)),
      ],),
    ),
    );
  }
}