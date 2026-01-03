import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/models/event.dart';
import 'package:event_app/data/firebase/event_firebase_database.dart';
import 'package:flutter/material.dart';

class EventListProvider extends ChangeNotifier{
  //todo: Data
  // الداتا الي اما تتغير هتقصر ف اكتر من مكان في الابلكيشن
   List<Event>eventList=[];
  List <Event>filterEventList=[];
   void getAllEvent()async{
    QuerySnapshot<Event> querySnapshot=await EventFirebaseDatabase.getCollectionOfEvent().get();
    eventList=querySnapshot.docs.map((docs){
      return docs.data();
    } ,).toList();
  filterEventList=eventList;  //all events
    notifyListeners();
   }
  
}