import 'package:event_app/core/provideers/app_configprovider.dart';
import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class UserDataCard extends StatefulWidget {
  final User? user;

  const UserDataCard({this.user, super.key});

  @override
  State<UserDataCard> createState() => _UserDataCardState();
}

class _UserDataCardState extends State<UserDataCard> {
  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfigprovider>(context);
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: appConfigProvider.isDark()
            ? AppColors.darkPurple
            : AppColors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcomeBack,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: appConfigProvider.isDark()
                              ? AppColors.offWhite
                              : AppColors.lightBlue,
                        ),
                      ),
                      Text(
                        widget.user?.displayName ?? "No Name",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: appConfigProvider.isDark()
                              ? AppColors.offWhite
                              : AppColors.lightBlue,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(children: [
                       Icon(Iconsax.location_outline, color: appConfigProvider.isDark()
                              ? AppColors.offWhite
                              : AppColors.lightBlue,
                              size: 20,
                        ),
                         SizedBox(width: 5,),
                         Text(
                        AppLocalizations.of(context)!.cairo,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: appConfigProvider.isDark()
                              ? AppColors.offWhite
                              : AppColors.lightBlue,
                        ),
                      ),
                      SizedBox(width: 5,),
                        Text(
                        AppLocalizations.of(context)!.egypt,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: appConfigProvider.isDark()
                              ? AppColors.offWhite
                              : AppColors.lightBlue,
                        ),
                      ),
                        
                      ],)
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    appConfigProvider.changeTheme(
                      appConfigProvider.isDark()
                          ? ThemeMode.light
                          : ThemeMode.dark,
                    );
                  },
                  icon: Icon(
                    appConfigProvider.isDark()
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode,
                    color: appConfigProvider.isDark()
                        ? AppColors.offWhite
                        : AppColors.lightBlue,
                  ),
                ),
                InkWell(
                  onTap: () {
                    appConfigProvider.changeLanguage(
                      appConfigProvider.isEn() ? "ar" : "en",
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appConfigProvider.isDark()
                          ? AppColors.offWhite
                          : AppColors.lightBlue,
                    ),
                    child: Text(
                      appConfigProvider.isEn() ? "En" : "ع",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: appConfigProvider.isDark()
                            ? AppColors.darkPurple
                            : AppColors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
