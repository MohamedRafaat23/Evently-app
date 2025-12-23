import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    //  تحقق من وجود categories
    if (Category.categories.isEmpty) {
      return const SizedBox.shrink();
    }
    // ابحث عن الـ category أو استخدم default
    final category = Category.categories.firstWhere(
      (e) => e.id == event.categoryId,
      orElse: () => Category.categories.first,
    );
    return AspectRatio(
      aspectRatio: 360 / 200,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    children: [
                      Text(
                        event.eventDate == null
                            ? ""
                            : DateTime.fromMillisecondsSinceEpoch(
                                event.eventDate!,
                              ).day.toString(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        event.eventDate == null
                            ? ""
                            : DateFormat('MMM', 'en')
                                  .format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      event.eventDate!,
                                    ),
                                  )
                                  .substring(0, 3),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.title ?? "",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Icon(Icons.favorite_border_outlined, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
