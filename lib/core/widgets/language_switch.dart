import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_app/core/provideers/app_configprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LangSwitch extends StatefulWidget {
  
  const LangSwitch({super.key});

  @override
  State<LangSwitch> createState() => _LangSwitchState();
}

class _LangSwitchState extends State<LangSwitch> {
  late  AppConfigprovider appConfigprovider;

  @override
  Widget build(BuildContext context) {
    appConfigprovider =Provider.of<AppConfigprovider>(context);
    return AnimatedToggleSwitch<String>.rolling(
      current: appConfigprovider.locale,
      onChanged: (locale) {
        appConfigprovider.changeLanguage(locale);
        
      },
      values: ["en", "ar"],
      style: ToggleStyle(borderColor: Theme.of(context).colorScheme.primary),
      iconBuilder: (value, selected) {
        if (value == "en") {
          return Image.asset("assets/images/LR.png");
        } else {
          return Image.asset("assets/images/EG.png");
        }
      },
      styleBuilder: (value) =>ToggleStyle(indicatorColor: Theme.of(context).primaryColor), 
    );
  }
}
