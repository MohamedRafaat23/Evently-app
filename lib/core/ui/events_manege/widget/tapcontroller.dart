// ignore_for_file: must_be_immutable
import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/providers/app_configprovider.dart';
import 'package:event_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tapcontroller extends StatefulWidget {
  Category category = Category.categories[0];
    final ValueChanged<Category> onCategoryChanged;
   Tapcontroller({super.key, required this.category, required this.onCategoryChanged});

  @override
  State<Tapcontroller> createState() => _TapcontrollerState();
}

class _TapcontrollerState extends State<Tapcontroller> {
   late Category selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category;
  }
  @override
  Widget build(BuildContext context) {
    var appConfigProvider=Provider.of<AppConfigprovider>(context);
    return   DefaultTabController(
                    length: Category.categories.length,
                    child: TabBar(
                      onTap: (index) {
                        setState(() {
                        selectedCategory = Category.categories[index];
                        });
                        widget.onCategoryChanged(selectedCategory);
                      },
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(horizontal: 2),
                      isScrollable: true,
                      //map every object in this list to widget(container)
                      tabs: Category.categories
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),

                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: widget.category.id == e.id
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                                  border: Border.all(
                                    width: 2,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      e.iconData,
                                      color: widget.category.id == e.id
                                          ? AppColors.white
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      appConfigProvider.isEn()
                                          ? e.nameEn
                                          : e.nameAr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: widget.category.id == e.id
                                                ? AppColors.white
                                                : Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
  }
}