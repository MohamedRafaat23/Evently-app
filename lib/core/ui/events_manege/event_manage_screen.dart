import 'package:event_app/core/models/event.dart';
import 'package:event_app/core/providers/event_list_provider.dart';
import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/core/ui/events_manege/widget/tapcontroller.dart';
import 'package:event_app/core/ui/home/tabs/mabs/mab_tab.dart';
import 'package:event_app/data/firebase/event_firebase_database.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';

class EventManagementScreen extends StatefulWidget {
  const EventManagementScreen({super.key});
  static const String routeName = " event screen";
  @override
  State<EventManagementScreen> createState() => _EventManagementScreenState();
}

class _EventManagementScreenState extends State<EventManagementScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Category selectedCategory = Category.categories[0];
  late ValueChanged<Category> onCategoryChanged;

  DateTime? selectedDate;
  TimeOfDay? selectTime;
  GlobalKey<FormState> formkey = GlobalKey();
  late EventListProvider eventListProvider;
  void addEvent() {
    if (formkey.currentState!.validate() &&
        selectedDate != null &&
        selectTime != null) {
      EventFirebaseDatabase.setEventInFirestore(
            Event(
              title: titleController.text,
              description: descriptionController.text,
              eventDate: selectedDate!.millisecondsSinceEpoch,
              eventTime: selectTime!.hour,
              categoryId: selectedCategory.id,
            ),
          )
          // if i dont want to use async and await we use call back function
          //call back function to listen in case of success and failure
          //if onlone=> use then
          //of offline=>use timeout
          .then((_) {
            // ✅ Success
            debugPrint("Event Added Successfully");
            //todo : refresh list to get last event
            Provider.of<EventListProvider>(
              context,
              listen: false,
            ).getAllEvent();
            Navigator.pop(context);
          })
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              debugPrint("Timeout: Check your internet connection");
            },
          )
          .catchError((error) {
            debugPrint("Error: $error");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.createEvent,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: formkey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(selectedCategory.imagePath),
                  ),
                  SizedBox(height: height * 0.01),
                  Tapcontroller(
                    category: selectedCategory,
                    onCategoryChanged: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.title,
                      prefixIcon: Icon(Icons.create),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.description,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(width: 5),
                      Text(
                        AppLocalizations.of(context)!.eventDate,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          DateTime? newSelectedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          selectedDate = newSelectedDate;
                          setState(() {});
                        },
                        child: Text(
                          selectedDate == null
                              ? AppLocalizations.of(context)!.chooseDate
                              : DateFormat("dd/MM/yyyy").format(selectedDate!),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(width: 5),
                      Text(
                        AppLocalizations.of(context)!.eventTime,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? newSelectedTime = await showTimePicker(
                            context: context,
                            initialTime: selectTime ?? TimeOfDay.now(),
                          );
                          if (newSelectedTime != null) {
                            selectTime = newSelectedTime;
                            setState(() {});
                          }
                        },
                        child: Text(
                          selectTime == null
                              ? AppLocalizations.of(context)!.chooseTime
                              : selectTime!.format(context),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)!.location,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: height * 0.01),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MapTab.routeName);
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.purple,
                          ),
                          child: Icon(
                            Icons.location_searching,
                            color: AppColors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.chooseEventLocation,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  FilledButton(
                    onPressed: () {
                      addEvent();
                    },
                    child: Text(AppLocalizations.of(context)!.addEvent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
