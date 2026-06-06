import 'package:event_app/core/ui/auth/forget_password/forget_password_screen.dart';
import 'package:event_app/core/ui/auth/login/login_screen.dart';
import 'package:event_app/core/ui/auth/register/register_screen.dart';
import 'package:event_app/core/ui/home/home_screen.dart';
import 'package:event_app/core/ui/home/tabs/home/add_event/add_even_screen.dart';
import 'package:event_app/core/ui/home/tabs/home/event_details/event_details.dart';
import 'package:event_app/core/ui/home/tabs/mabs/mab_tab.dart';
import 'package:event_app/core/ui/onpoarding/export_app.dart';
import 'package:event_app/core/ui/onpoarding/onpoarding_screen.dart';
import 'package:event_app/core/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case OnpoardingScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const OnpoardingScreen(),
        );

      case ExportApp.routeName:
        return MaterialPageRoute(
          builder: (_) => ExportApp(),
        );

      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      case SingupScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SingupScreen(),
        );

      case ForgetPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
        );

      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      case EventManagementScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => EventManagementScreen(),
        );

      case MapTab.routeName:
        return MaterialPageRoute(
          builder: (_) => MapTab(),
        );

      case EventDetails.routeName:
        return MaterialPageRoute(
             settings: settings,
          builder: (_) => EventDetails(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route Not Found'),
            ),
          ),
        );
    }
  }
}