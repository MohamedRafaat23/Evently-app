import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/providers/event_list_provider.dart';
import 'package:event_app/core/ui/home/tabs/home/widgets/event_card.dart';
import 'package:event_app/core/ui/home/tabs/home/widgets/user_data_card.dart';
import 'package:event_app/data/firebase/event_firebase_database.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Category> categories = [];
  late Category selectedCategory;
  @override
  void initState() {
    super.initState();
    categories.add(
      Category(
        id: -1,
        nameEn: "All",
        nameAr: "الكل",
        imagePath: "",
        iconData: Iconsax.export_1_bold,
      ),
    );
    //add all other categories
    categories.addAll(Category.categories);
    //يعني اول عنصر في الليسته هيكون  "All"
    selectedCategory = categories.first;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventListProvider>(context, listen: false).getAllEvent();
    });
  }
  void changeSelectedCategory(int index) {
    setState(() {
      selectedCategory = categories[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        UserDataCard(
          user: FirebaseAuthService.getUserData(),
          selectedCategory: selectedCategory,
          changeSelectedCategory: changeSelectedCategory,
          categories: categories,
        ),
        SizedBox(height: height * 0.02),
        Expanded(
          child: StreamBuilder(
          stream: EventFirebaseDatabase.filterEvents(selectedCategory.id),
           builder: (context , snapshot){
             if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (snapshot.hasError) {
                return  Center(child: Text("Something went wrong"));
              }
              
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.noEventsFound,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              }
            final eventList = snapshot.data!.docs
                  .map((doc) => doc.data())
                  .toList();
              return  ListView.separated(
                  padding: EdgeInsets.all(height * 0.02),
                  itemCount: eventList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * 0.02);
                  },
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      child: EventCard(
                        event: eventList[index],
                      ),
                    );
                  },
                );

           }),
        ),
      ],
    );
  }
}
