import 'package:event_app/core/models/event.dart';
import 'package:event_app/core/provideers/app_configprovider.dart';
import 'package:event_app/core/theme/app_color.dart';
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
  DateTime? selectedDate;
  TimeOfDay? selectTime;
  GlobalKey<FormState>formkey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfigprovider>(context);

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
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Image.asset(selectedCategory.imagePath),
                  ),
                  SizedBox(height: 8),
                  DefaultTabController(
                    length: Category.categories.length,
                    child: TabBar(
                      onTap: (index) {
                        selectedCategory = Category.categories[index];
                        setState(() {});
                      },
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(horizontal: 2),
                      isScrollable: true,
                      //map every object in this list to widget(container)
                      tabs: Category.categories
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
              
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: selectedCategory.id == e.id
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                                  border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      e.iconData,
                                      color: selectedCategory.id == e.id
                                          ? AppColors.white
                                          : Theme.of(context).colorScheme.primary,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      appConfigProvider.isEn()
                                          ? e.nameEn
                                          : e.nameAr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: selectedCategory.id == e.id
                                                ? AppColors.white
                                                : Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.title,
                      prefixIcon: Icon(Icons.create),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 5),
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
                  SizedBox(height: 5),
                  OutlinedButton(
                    onPressed: () {},
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
                  SizedBox(height: 10),
                  FilledButton(
                    onPressed: () {
                      if(formkey.currentState!.validate() && selectedDate!=null &&selectTime!=null ){
                    try{
                          EventFirebaseDatabase.setEventInFirestore(
                        Event(
                          title: titleController.text,
                          description: descriptionController.text,
                          eventDate: selectedDate?.millisecondsSinceEpoch,
                          eventTime: selectTime?.hour,
                          categoryId: selectedCategory.id,
                        ),
                      ); 


                    }catch (e){
                      rethrow;

                    }
                      }                    },
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
