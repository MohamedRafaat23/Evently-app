import 'package:event_app/core/theme/app_color.dart';
import 'package:event_app/core/ui/auth/login_screen.dart';
import 'package:event_app/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExportApp extends StatefulWidget {
  const ExportApp({super.key});
  static const String routeName = "export";

  @override
  State<ExportApp> createState() => _ExportAppState();
}

class _ExportAppState extends State<ExportApp> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // الصفحات اللي هتتعرض
    final pages = [
      {
        "title": AppLocalizations.of(context)!.findEventsThatInspireYou,
        "description": AppLocalizations.of(context)!.eventDiscoveryDescription,
        "image": "assets/images/mobile.png",
      },
      {
        "title": AppLocalizations.of(context)!.effortlessEventPlanning,
        "description": AppLocalizations.of(
          context,
        )!.effortlessEventPlanningDescription,
        "image": "assets/images/being-creative-1.png",
      },
      {
        "title": AppLocalizations.of(
          context,
        )!.connectwithFriendsandShareMoments,
        "description": AppLocalizations.of(
          context,
        )!.connectWithFriendsDescription,
        "image": "assets/images/being-creative2.png",
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// الجزء اللي فيه الـ PageView
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Image.asset("assets/images/logo5.png")],
                        ),
                        SizedBox(height: 10,),
                        Expanded(child: Image.asset(page["image"]!)),
                        Text(
                          page["title"]!,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(color: AppColors.purple),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          page["description"]!,
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

           

            /// الجزء بتاع الزرارين (ثابت تحت)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.purple, width: 2),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (currentIndex > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                   SmoothPageIndicator(
                          controller: _pageController,
                          count: pages.length,
                          axisDirection: Axis.horizontal,
                          effect:WormEffect(
                            dotColor: AppColors.black,
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: AppColors.purple
                           
                            
                          ),
                
                        ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.purple, width: 2),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (currentIndex < pages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        
                        }else{
                           Navigator.pushNamed(context, LoginScreen.routeName);
                        }
                         
                       
                       
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ),
                 
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
