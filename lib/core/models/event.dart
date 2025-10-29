import 'package:event_app/core/models/category_model.dart';
class Event{
  String ? id;
  String ?title;
  String ?description;
  int ?eventDate;
  int ?eventTime;
int ?categoryId;
  Event({
    this.id,
    this.title,
    this.description,
    this.eventDate,
    this.eventTime,
    this.categoryId,
    });
  //create function to convert Event object to json object(to firestore)
    Map<String, dynamic> toFireStore() {
      return {
        'id': id,
        'title': title,
        'description': description,
        'eventDate': eventDate,
        'eventTime': eventTime,
        //from category object to its id (search for id in the list of categories)
        'categoryId': categoryId,
      }; 

    }
    //named constructor to create an Event object from a Firestore document
    Event.fromFireStore(Map<String, dynamic> data) {
      id = data['id'];
      title = data['title'];
      description = data['description'];
      eventDate = data['eventDate'];
      eventTime = data['eventTime'];
      //from category id to category object (search for the object in the list of categories)
      //داله بتدور في الليست عشان تجيب الابجكت اللي الايدي بتاعه بيساوي الايدي اللي جاي من الفايرستور
      categoryId=Category.categories.firstWhere((element) => element.id==data['categoryId']).id;
      
  }
}