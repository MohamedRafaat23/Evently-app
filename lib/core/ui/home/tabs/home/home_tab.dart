
import 'package:event_app/core/ui/home/tabs/home/widgets/user_data_card.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
 
  @override
  Widget build(BuildContext context) {
    
    return  Column(
      children: [
       UserDataCard(
        user: FirebaseAuthService.getUserData(),
        
       )
      ],
    );
  }
}