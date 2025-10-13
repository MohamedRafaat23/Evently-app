import 'package:event_app/core/models/category_model.dart';


class Event{
  String ? id;
  String ?title;
  String ?description;
  int ?eventDate;
  int ?eventTime;
  Category?category;

  Event({
    this.id,
    this.title,
    this.description,
    this.eventDate,
    this.eventTime,
    this.category,
    });

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'title': title,
        'description': description,
        'eventDate': eventDate,
        'eventTime': eventTime,
        //from category object to its id (search for id in the list of categories)
        'category': category?.id,
      };

    }
    //named constructor to create an Event object from a Firestore document
    Event.fromFireStore(Map<String, dynamic> json) {
      id = json['id'];
      title = json['title'];
      description = json['description'];
      eventDate = json['eventDate'];
      eventTime = json['eventTime'];
      //from category id to category object (search for the object in the list of categories)
      //داله بتدور في الليست عشان تجيب الابجكت اللي الايدي بتاعه بيساوي الايدي اللي جاي من الفايرستور
      category=Category.categories.firstWhere((element)=>element.id==json["category"]);
      
  }
}