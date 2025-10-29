import 'dart:io';

import 'package:event_app/core/provideers/app_configprovider.dart';
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
    var user=FirebaseAuthService.getUserData;
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;

  
    return  Column(
        
        children: [ 
          Container(
            width: double.infinity,
        padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
          color:appConfigProvider.isDark()?AppColors.darkPurple:AppColors.purple  ,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
          
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(children: [
                Container(
                  width: width*0.2,
                  height: height*0.1,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(32),
                //  DecorationImage(
                //       image: AssetImage("assets/images/logo5.png"),
                //       fit: BoxFit.contain,
                //     ),
                
                  ),
                  
                  child:   GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 150,
                              height: 120,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xffFFF1D4),
                                  width: 1,
                                ),
                              ),
                              child: _image == null
                                  ? Center(
                                      child: Image.asset(
                                        "assets/images/logo5.png",
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _image!,
                                        width: 140,
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ), 
                  ),
              ],),
              SizedBox(width: width*0.05,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user()?.displayName??"User Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),),
                  SizedBox(height: height*0.01,),
                  Text(user()?.email??"user email",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  ),),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [ 
         Text(AppLocalizations.of(context)!.language,style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: appConfigProvider.isDark()
                                ? AppColors.offWhite
                                : AppColors.black,fontWeight: FontWeight.w500 ),),
         Spacer(),
        LangSwitch(),],
        ),
      ),
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [ 
         Text(AppLocalizations.of(context)!.theme ,
         style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: appConfigProvider.isDark()
                                ? AppColors.offWhite
                                : AppColors.black,fontWeight: FontWeight.w500 ),
         ),
         Spacer(),
        ThemeSwitch(),],
        ),
      ),
        ],
      )
    ;
  }
}