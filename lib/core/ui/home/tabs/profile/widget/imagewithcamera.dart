import 'dart:io';

import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagewithcamera extends StatefulWidget {
  const Imagewithcamera({super.key});

  @override
  State<Imagewithcamera> createState() => _ImagewithcameraState();
}

class _ImagewithcameraState extends State<Imagewithcamera> {
  var user = FirebaseAuthService.getUserData;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future _pickImage() async {
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
   var height=MediaQuery.of(context).size.height;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), 
                  ),
                ],
              ),
              child: ClipOval(
                child: _image == null
                    ? Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          "assets/images/logo5.png",
                          fit: BoxFit.contain,
                        ),
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
                  border: Border.all(color: AppColors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: AppColors.white,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height*0.02),
        Text(
          user()?.displayName ?? "User Name",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColors.offWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height*0.01),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            user()?.email ?? "user@email.com",
            style:  Theme.of(context).textTheme.bodyMedium!.copyWith( color: AppColors.offWhite,),
          ),
        ),
      ],
    );
  }
}
