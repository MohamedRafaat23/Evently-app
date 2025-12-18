import 'package:event_app/core/models/category_model.dart';
import 'package:event_app/core/providers/app_configprovider.dart';
import 'package:event_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultTapController extends StatefulWidget {
  final Category selectedCategory;
  final List<Category>categories;
  final Function(int) changeSelectedCategory;
  const DefaultTapController({super.key, required this.categories , required this.selectedCategory, required this.changeSelectedCategory});

  @override
  State<DefaultTapController> createState() => _DefaultTapControllerState();
}

class _DefaultTapControllerState extends State<DefaultTapController> {
  @override
  Widget build(BuildContext context) {
        var appConfigProvider = Provider.of<AppConfigprovider>(context);
    return  DefaultTabController(
              length: widget.categories.length,
              child: TabBar(
                onTap: (index) {
                  widget.changeSelectedCategory(index);
                  setState(() {});
                },
                dividerHeight: 0,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.symmetric(horizontal: 2),
                isScrollable: true,

                //map every object in this list to widget(container)
                tabs: widget.categories
                    .map(
                      (element) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),

                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: widget.selectedCategory.id == element.id
                                ? AppColors.white
                                : Colors.transparent,
                            border: Border.all(
                              width: 2,
                              color: AppColors.white,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                element.iconData,
                                color:widget. selectedCategory.id == element.id
                                    ? appConfigProvider.isDark()
                                          ? AppColors.darkPurple
                                          : AppColors.purple
                                    : AppColors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                appConfigProvider.isEn() ? element.nameEn : element.nameAr,
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      color: widget.selectedCategory.id == element.id
                                          ? appConfigProvider.isDark()
                                                ? AppColors.darkPurple
                                                : AppColors.purple
                                          : AppColors.white,
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