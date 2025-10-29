

import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/ui/home/tabs/home/widgets/user_data_card.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //create a list to hold all categories
  List<Category> categories = [];
  //late variable to hold selected category
  late Category selectedCategory;
  @override
 void initState() {
    
    super.initState();
    //add "All" to categories at the beginning of the list
    categories.add(Category(id: -1, nameEn: "All", nameAr: "الكل", imagePath: "", iconData: Iconsax.export_1_bold));
    //add all other categories
    categories.addAll(Category.categories);
    //يعني اول عنصر في الليسته هيكون  "All"
   selectedCategory=categories.first;
   
  }


  
  @override
  Widget build(BuildContext context) {
    
    return  Column(
      children: [
       UserDataCard(
        user: FirebaseAuthService.getUserData(),
        selectedCategory: selectedCategory,
        changeSelectedCategory:changeSelectedCategory,
        categories: categories,
       )
      ],
    );
  }
  //function to change selected category
  void changeSelectedCategory(int index){
    setState(() {
      selectedCategory=categories[index];
    });
  }
   

}