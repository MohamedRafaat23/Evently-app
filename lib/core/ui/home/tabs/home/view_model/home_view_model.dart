import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/models/event.dart';
import 'package:event_app/core/ui/home/tabs/home/view_model/navigator_view_model.dart';
import 'package:event_app/data/firebase/event_firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
class HomeViewModel extends ChangeNotifier {
 late NavigatorViewModel? navigatorViewModel;
  late Category selectedCategory;
  List<Category> categories = [];
  List<Event> eventList = [];
  List<Event> filteredEventList = [];

  bool isLoading = false;
  String? errorMessage;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  HomeViewModel() {
    _initCategories();
    getAllEvents();
  }

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
    //
    selectedCategory = Category.categories.first;
  }

  Future<void> getAllEvents() async {
    isLoading = true;
    notifyListeners();
    try {
      final snapshot =
          await EventFirebaseDatabase.getCollectionOfEvent().get();
      eventList = snapshot.docs.map((e) => e.data()).toList();
      _filterEvents();
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  void _filterEvents() {
    filteredEventList = selectedCategory.id == -1
        ? eventList
        : eventList
            .where((e) => e.categoryId == selectedCategory.id)
            .toList();
  }

  Future<void> addEvent() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      navigatorViewModel?.showError(
        "Please fill all fields and select date & time",
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final event = Event(
        title: titleController.text,
        description: descriptionController.text,
        eventDate: selectedDate!.millisecondsSinceEpoch,
        eventTime:
            selectedTime!.hour * 60 + selectedTime!.minute,
        categoryId: selectedCategory.id,
      );

      await EventFirebaseDatabase.setEventInFirestore(event);
      await getAllEvents();
      navigatorViewModel?.goToHome();
    } catch (e) {
      navigatorViewModel?.showError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeSelectedCategory(int index) {
    selectedCategory = categories[index];
    _filterEvents();
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
