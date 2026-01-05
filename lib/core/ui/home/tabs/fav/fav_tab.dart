import 'package:event_app/core/ui/home/tabs/home/widgets/event_card.dart';
import 'package:event_app/data/firebase/event_firebase_database.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}
class _FavoriteTabState extends State<FavoriteTab> {
  var userId=FirebaseAuthService.getUserData()?.uid??"";
  @override
  Widget build(BuildContext context) {
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;
      var localization=AppLocalizations.of(context)!;
    return SafeArea(
      child: 
         Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText:localization.searchForEvent ,
                  prefixIcon: Icon(Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                  )
                ),
              ),
               Expanded(
          child: StreamBuilder(
          stream: EventFirebaseDatabase.getUserFavList(userId),
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
          ],),
        ),
    );
  }
}