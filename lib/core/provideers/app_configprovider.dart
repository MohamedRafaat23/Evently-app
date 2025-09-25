import 'package:flutter/material.dart';

class AppConfigprovider extends ChangeNotifier{
  ThemeMode themeMode =ThemeMode.light;
  String locale = 'en';

  void changeTheme(ThemeMode newTheme){
    themeMode =newTheme;
    notifyListeners();

  }
  void changeLanguage(String locale){
    this.locale =locale;
    notifyListeners();
  }

}
