import 'package:event_app/core/ui/onpoarding/onpoarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_){
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed((context), OnpoardingScreen.routeName);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo_evently.png"),
        ],
      )
    ],) );
  }
}
