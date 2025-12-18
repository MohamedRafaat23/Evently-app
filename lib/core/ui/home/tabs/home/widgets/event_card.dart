import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/models/event.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});
  
  @override
  Widget build(BuildContext context) {
    // ✅ تحقق من وجود categories
    if (Category.categories.isEmpty) {
      return const SizedBox.shrink(); // أو placeholder widget
    }
    
    // ✅ ابحث عن الـ category أو استخدم default
    final category = Category.categories.firstWhere(
      (e) => e.id == event.categoryId,
      orElse: () => Category.categories.first,
    );
    
    return AspectRatio(
      aspectRatio: 360 / 200,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).colorScheme.primary,
          width: 2,
          ),
          image: DecorationImage(
            image: AssetImage(category.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                padding:  EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Text(
                  event.title ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}