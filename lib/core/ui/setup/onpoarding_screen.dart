import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/core/ui/setup/export_app.dart';
import 'package:event_app/core/widgets/language_switch.dart';
import 'package:event_app/core/widgets/theme_switch.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class OnpoardingScreen extends StatelessWidget {
  const OnpoardingScreen({super.key});
  static const String routeName = "onPoarding";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset("assets/images/logo5.png")],
              ),
              Expanded(child: Image.asset("assets/images/image3.png")),
              Text(
                AppLocalizations.of(context)!.personalizeYourExperience,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: AppColors.purple),
              ),

              SizedBox(height: 10),
              Text(
               AppLocalizations.of(context)!.chooseYourPreferredThemeAndLanguageMessage,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!,
              ),
              Row(
                children: [
                  Text(
                   AppLocalizations.of(context)!.language,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: AppColors.purple),
                  ),
                  Spacer(),
                 LangSwitch(),
                ],
              ),
              SizedBox(height: 5,),
                Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: AppColors.purple),
                  ),
                  Spacer(),
                ThemeSwitch(),
                ],
              ),
               SizedBox(height: 10,),
              FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, ExportApp.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(AppLocalizations.of(context)!.letsStart)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
