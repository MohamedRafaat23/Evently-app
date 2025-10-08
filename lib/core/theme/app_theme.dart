import 'package:event_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.purple,
      onPrimary: AppColors.lightBlue,
      secondary: AppColors.black,
      onSecondary: AppColors.lightBlue,
      error: AppColors.red,
      onError: AppColors.offWhite,
      surface: AppColors.lightBlue,
      onSurface: AppColors.black,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        foregroundColor: AppColors.purple,
        side: BorderSide(width: 1, color: AppColors.purple),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.gray,
      suffixIconColor: AppColors.gray,
      hintStyle: TextStyle(fontSize: 14,
      color: AppColors.gray
      
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
         borderSide: BorderSide(color: AppColors.gray, width: 1),

      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.gray, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red, width: 1),
      ),
       focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.gray, width: 1),
      ), 
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red, width: 1),
      ),
    ),
   bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.purple,
    selectedItemColor: AppColors.lightBlue,
    unselectedItemColor: AppColors.lightBlue,

   ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.black,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: AppColors.purple),
      titleMedium: TextStyle(color: AppColors.purple),
      titleSmall: TextStyle(color: AppColors.purple),
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),
      labelLarge: TextStyle(color: AppColors.black),
      labelMedium: TextStyle(color: AppColors.black),
      labelSmall: TextStyle(color: AppColors.black),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.purple,
      onPrimary: AppColors.darkPurple,
      secondary: AppColors.offWhite,
      onSecondary: AppColors.darkPurple,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.darkPurple,
      onSurface: AppColors.offWhite,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        foregroundColor: AppColors.purple,
        side: BorderSide(width: 1, color: AppColors.purple),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.black,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColors.purple,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: AppColors.purple),
      titleSmall: TextStyle(color: AppColors.purple),
      bodyLarge: TextStyle(color: AppColors.offWhite),
      bodyMedium: TextStyle(color: AppColors.offWhite),
      bodySmall: TextStyle(color: AppColors.offWhite),
      labelLarge: TextStyle(color: AppColors.offWhite),
      labelMedium: TextStyle(color: AppColors.offWhite),
      labelSmall: TextStyle(color: AppColors.offWhite),
    ),

     inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.offWhite,
      suffixIconColor: AppColors.offWhite,
      hintStyle: TextStyle(fontSize: 14,
      color: AppColors.offWhite
      
      ),disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
         borderSide: BorderSide(color: AppColors.offWhite, width: 1),

      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.purple, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red, width: 1),
      ),
      focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.purple, width: 1),
      ), 
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red, width: 1),
      ),
    ),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkPurple,
    selectedItemColor: AppColors.offWhite,
    unselectedItemColor: AppColors.offWhite,
    
   ),

  );
}
