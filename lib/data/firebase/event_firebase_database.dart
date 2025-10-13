import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/models/event.dart';

class EventFirebaseDatabase {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  //فاير بيز بيعمل كونفيرتر عشان يحول الابجكت بتاع الايفينت الى جيسون والعكس
  static CollectionReference<Event> getCollectionReference() {
    return db
        .collection("events")
        .withConverter(
          fromFirestore: (data, snapshot) =>
              Event.fromFireStore(data.data()!),
          toFirestore: (data, _) => data.toJson(),
        );
  }
  //create event
 static Future <void>createEvent(Event event)async{
    try{
      //بيخزن الداتا كا دوكيومنت ريفرانس
        var doc=getCollectionReference().doc();
        //من هنا بنحدد الايدي بتاع الدوكيمنت  وبساويه بالايدي بتاع الايفينت
        event.id=doc.id;
        doc.set(event)  ;
    }catch(e){
      print(e);
  
  }
  }
}
