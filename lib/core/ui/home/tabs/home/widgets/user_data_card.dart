import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/providers/app_configprovider.dart';
import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/core/ui/home/tabs/home/widgets/default_tap_controller.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class UserDataCard extends StatefulWidget {
  final User? user;
  final Category selectedCategory;
  final List<Category> categories;
  final Function(int) changeSelectedCategory;
  
  const UserDataCard({
    this.user,
    required this.selectedCategory,
    required this.categories,
    required this.changeSelectedCategory,
    super.key,
  });

  @override
  State<UserDataCard> createState() => _UserDataCardState();
}

class _UserDataCardState extends State<UserDataCard> {
  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfigprovider>(context);
    var size = MediaQuery.of(context).size;
    var width = size.width;
  
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: size.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: appConfigProvider.isDark()
            ? AppColors.darkPurple
            : AppColors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * 0.06),
          bottomRight: Radius.circular(width * 0.06),
        ),
      ),
      child: SafeArea(
        child: Column(
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
                          fontSize: width * 0.035,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        widget.user?.displayName ?? "No Name",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: width * 0.055,
                          fontWeight: FontWeight.bold,
                          color: appConfigProvider.isDark()
                              ? AppColors.offWhite
                              : AppColors.lightBlue,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Icon(
                            Iconsax.location_outline,
                            color: appConfigProvider.isDark()
                                ? AppColors.offWhite
                                : AppColors.lightBlue,
                            size: width * 0.045,
                          ),
                          SizedBox(width: width * 0.01),
                          Text(
                            AppLocalizations.of(context)!.cairo,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: appConfigProvider.isDark()
                                  ? AppColors.offWhite
                                  : AppColors.lightBlue,
                              fontSize: width * 0.035,
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          Text(
                            AppLocalizations.of(context)!.egypt,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: appConfigProvider.isDark()
                                  ? AppColors.offWhite
                                  : AppColors.lightBlue,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
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
                    size: width * 0.06,
                  ),
                ),
                InkWell(
                  onTap: () {
                    appConfigProvider.changeLanguage(
                      appConfigProvider.isEn() ? "ar" : "en",
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.025),
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
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            DefaultTapController(
              categories: widget.categories,
              selectedCategory: widget.selectedCategory,
              changeSelectedCategory: widget.changeSelectedCategory,
            )
          ],
        ),
      ),  
    );
  }
}