// ignore_for_file: must_be_immutable
import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/providers/app_configprovider.dart';
import 'package:event_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tapcontroller extends  StatelessWidget {
  final Category selectedCategory;
  final ValueChanged<Category> onCategoryChanged;
  const Tapcontroller({super.key, required this.selectedCategory, required this.onCategoryChanged});

  @override
  Widget build(BuildContext context) {
    var appConfigProvider=Provider.of<AppConfigprovider>(context);
    return   DefaultTabController(
                    length: Category.categories.length,
                    child: TabBar(
                      onTap: (index) { 
                        onCategoryChanged(Category.categories[index]);
                      },
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(horizontal: 2),
                      isScrollable: true,
                      //map every object in this list to widget(container)
                      tabs: Category.categories
                          .map(
                            (e) {
                   final bool isSelected = selectedCategory.id == e.id;
                          //UI OF TapBar 
                              return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSelected
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
                                      color: isSelected
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
                                            color:isSelected
                                                ? AppColors.white
                                                : Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );}
                          )
                          .toList(),
                    ),
                  );
  }
}