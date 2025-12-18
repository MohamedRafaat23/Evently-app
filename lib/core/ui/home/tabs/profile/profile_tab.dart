import 'dart:io';

import 'package:event_app/core/providers/app_configprovider.dart';
import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/core/widgets/language_switch.dart';
import 'package:event_app/core/widgets/theme_switch.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfigprovider>(context);
    var user = FirebaseAuthService.getUserData;

    return Column(
      children: [
        // Header Section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: appConfigProvider.isDark()
                ? AppColors.darkPurple
                : AppColors.purple,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
            ),
          ),
          child: Column(
            children: [
              // Profile Image with Camera Icon
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 3),
                    ),
                    child: ClipOval(
                      child: _image == null
                          ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset("assets/images/logo5.png"),
                            )
                          : Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppColors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // User Name
              Text(
                user()?.displayName ?? "User Name",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              // User Email
              Text(
                user()?.email ?? "user@email.com",
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Language Setting
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: appConfigProvider.isDark()
                  ? AppColors.darkPurple.withOpacity(0.3)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.purple.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.language,
                  color: AppColors.purple,
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: appConfigProvider.isDark()
                        ? AppColors.offWhite
                        : AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const LangSwitch(),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Theme Setting
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: appConfigProvider.isDark()
                  ? AppColors.darkPurple.withOpacity(0.3)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.purple.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  color: AppColors.purple,
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: appConfigProvider.isDark()
                        ? AppColors.offWhite
                        : AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const ThemeSwitch(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}