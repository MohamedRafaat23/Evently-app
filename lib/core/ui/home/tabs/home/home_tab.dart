
import 'package:event_app/core/ui/home/tabs/home/view_model/home_view_model.dart';
import 'package:event_app/core/ui/home/tabs/home/widgets/event_card.dart';
import 'package:event_app/core/ui/home/tabs/home/widgets/user_data_card.dart';
import 'package:event_app/data/firebase/firebase_auth.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            children: [
              UserDataCard(
                user: FirebaseAuthService.getUserData(),
                selectedCategory: viewModel.selectedCategory,
                categories: viewModel.categories,
                changeSelectedCategory: (index) {
                  viewModel.changeSelectedCategory(index);
                },
              ),
              SizedBox(height: height * 0.02),

              Expanded(
                child: Builder(
                  builder: (_) {
                    if (viewModel.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (viewModel.filteredEventList.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.noEventsFound,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge,
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.all(height * 0.02),
                      itemCount: viewModel.filteredEventList.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: height * 0.02),
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.01),
                          child: EventCard(
                            event: viewModel.filteredEventList[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
