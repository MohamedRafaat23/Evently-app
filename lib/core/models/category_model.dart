import 'package:flutter/material.dart';

class Category {
  final int id;
  final String nameEn;
  final String nameAr;
  final String imagePath;
  final IconData iconData;

  const Category({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
    required this.iconData,
  });

  static List<Category> categories =  [
    Category(
      id: 0,
      nameEn: 'Sport',
      nameAr: 'رياضة',
      imagePath: 'assets/caregories_images/sport.png',
      iconData: Icons.sports_soccer,
    ),
    Category(
      id: 1,
      nameEn: 'Birthday',
      nameAr: 'عيد ميلاد',
      imagePath: 'assets/caregories_images/birthday.png',
      iconData: Icons.cake,
    ),
Category(
      id: 2,
      nameEn: 'Meeting',
      nameAr: 'اجتماع',
      imagePath: 'assets/caregories_images/meeting.png',
      iconData: Icons.people_alt,
    ),
    Category(
      id: 3,
      nameEn: 'Gaming',
      nameAr: 'ألعاب',
      imagePath: 'assets/caregories_images/gaming.png',
      iconData: Icons.gamepad,
    ),
    Category(
      id: 4,
      nameEn: 'Eating',
      nameAr: 'أكل',
      imagePath: 'assets/caregories_images/eating.png',
      iconData: Icons.restaurant,
    ),
    Category(
      id: 5,
      nameEn: 'Holiday',
      nameAr: 'إجازة',
      imagePath: 'assets/caregories_images/holiday.png',
      iconData: Icons.beach_access,
    ),
    Category(
      id: 6,
      nameEn: 'Exhibition',
      nameAr: 'معرض',
      imagePath: 'assets/caregories_images/exhibition.png',
      iconData: Icons.art_track,
    ),
    Category(
      id: 7,
      nameEn: 'Workshop',
      nameAr: 'ورشة عمل',
      imagePath: 'assets/caregories_images/workshop.png',
      iconData: Icons.construction,
    ),
    Category(
      id: 8,
      nameEn: 'Book Club',
      nameAr: 'نادي كتاب',
      imagePath: 'assets/caregories_images/book_club.png',
      iconData: Icons.menu_book,
    )
    ];

  
}