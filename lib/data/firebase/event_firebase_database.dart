import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/models/event.dart';

class EventFirebaseDatabase {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  //فاير بيز بيعمل كونفيرتر عشان يحول الابجكت بتاع الايفينت الى جيسون والعكس
  static CollectionReference<Event> getCollectionOfEvent() {
    return db
        .collection(Event.collectionName).
        // بتعرف الفايربيز البينات الي هتاخدها 
        withConverter<Event>( 
          fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, _) => event.toFireStore(),
        );
  }

  //Create Event to set in firestore
  static Future<void> setEventInFirestore(Event event)  {
    //take refrance from methoud getCollectionOfEvent and create document
   var docRefrance = getCollectionOfEvent().doc();
   //assign doc-id to event-id
    event.id=docRefrance.id;
    //save data
   return  docRefrance.set(event);
  }
}
