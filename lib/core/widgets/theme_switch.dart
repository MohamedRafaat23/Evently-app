import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_app/core/providers/app_configprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _LangSwitchState();
}

class _LangSwitchState extends State<ThemeSwitch> {
  late  AppConfigprovider appConfigprovider;

  @override
  Widget build(BuildContext context) {
    appConfigprovider =Provider.of<AppConfigprovider>(context);
    return AnimatedToggleSwitch<ThemeMode>.rolling(
      current: appConfigprovider.themeMode,
      values: [ThemeMode.light, ThemeMode.dark],
      onChanged:(theme){
        appConfigprovider.changeTheme(theme);
      } ,
      style: ToggleStyle(borderColor: Theme.of(context).colorScheme.primary),
      iconBuilder: (value, selected) {
        if (value == ThemeMode.dark) {
          return  Icon(Icons.dark_mode_sharp);
        } else {
          return  Icon(Icons.light_mode,);
        }
      },
      styleBuilder: (value) =>ToggleStyle(indicatorColor: Theme.of(context).primaryColor), 
    );
  }
}
