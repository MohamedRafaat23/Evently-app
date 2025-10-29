import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/models/event.dart';

class EventFirebaseDatabase {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  //فاير بيز بيعمل كونفيرتر عشان يحول الابجكت بتاع الايفينت الى جيسون والعكس
  static CollectionReference<Event> getCollectionReference() {
    return db
        .collection("events")
        .withConverter<Event>(
          fromFirestore: (data, snapshot) => Event.fromFireStore(data.data()!),
          toFirestore: (data, _) => data.toFireStore(),
        );
  }

  //create event function to set this data in firestore
  static Future<void> setEventInFirestore(Event refevent) async {
    //بيخزن الداتا كا دوكيومنت ريفرانس
    var ref = getCollectionReference().doc();
    //من هنا بنحدد الايدي بتاع الدوكيمنت  وبساويه بالايدي بتاع الايفينت
    refevent.id = ref.id;
    ref.set(refevent);
  }
}
