import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/models/event.dart';
import 'package:event_app/core/ui/home/tabs/home/view_model/navigator_view_model.dart';
import 'package:event_app/data/firebase/event_firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeViewModel extends ChangeNotifier {
  List<Category> categories = [];
  late Category selectedCategory;
  List<Event> eventList = [];
  List<Event> filteredEventList = [];
  bool isLoading = false;
  String? errorMessage;
late NavigatorViewModel navigatorViewModel;

  HomeViewModel() {
    _initCategories();
    getAllEvents();
  }

  /// Initialize categories
  void _initCategories() {
    categories = [
      Category(
        id: -1,
        nameEn: "All",
        nameAr: "الكل",
        imagePath: "",
        iconData: Iconsax.export_1_bold,
      ),
      ...Category.categories,
    ];
    selectedCategory = categories.first;
  }

  /// Change selected category
  void changeSelectedCategory(int index) {
    selectedCategory = categories[index];
    _filterEvents();
    notifyListeners();
  }

  /// Get all events from Firebase
  Future<void> getAllEvents() async {
    isLoading = true;
     errorMessage = null;
    notifyListeners();
  try{
      QuerySnapshot<Event> querySnapshot =
        await EventFirebaseDatabase.getCollectionOfEvent().get();
    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();
      _filterEvents();

  }catch(e){
     errorMessage = e.toString();
  }
    isLoading = false;
    notifyListeners();
  }

  /// Filter events by category
  void _filterEvents() {
    if (selectedCategory.id == -1) {
      filteredEventList = eventList;
    } else {
      filteredEventList = eventList
          .where((event) => event.categoryId == selectedCategory.id)
          .toList();
    }
  }
  void setEventInFirestore(Event event)async{
     isLoading = true;
     errorMessage = null;
     notifyListeners();
    try {
    await EventFirebaseDatabase.setEventInFirestore(event);
    await getAllEvents(); // refresh list after adding
    navigatorViewModel.goToHome(); // لو نجح، ارجع
  } catch (e) {
    errorMessage = e.toString();
    navigatorViewModel.showError(errorMessage!);
  } finally {
    isLoading = false;
    notifyListeners();
  }
}
}
