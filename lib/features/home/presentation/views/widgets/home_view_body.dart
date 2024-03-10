import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/app_notificationsold.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/home_box_widget.dart';
import 'package:lottie/lottie.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int activeIndex = 1;

  @override
  Widget build(BuildContext context) {
    final titlesList2 = <String>[
      AppStrings.azkarSabah,
      AppStrings.azkarMasaa,
      AppStrings.hadith,
      AppStrings.werdDay,
      AppStrings.quranAgzaa,
      AppStrings.hesnMuslim,
    ];
    final iconsList2 = <String>[
      ImageAssets.azkarSabah,
      ImageAssets.azkarMasaa,
      ImageAssets.hadith,
      ImageAssets.werd,
      ImageAssets.agzaa,
      ImageAssets.hesnMuslim,
    ];
    final routesList2 = <String>[
      Routes.azkarSabahRoute,
      Routes.azkarMasaaRoute,
      Routes.hadithRoute,
      Routes.werdViewRoute,
      Routes.quranAgzaa,
      Routes.hesnMuslimRoute,
    ];
    final typesList2 = <String>[
      'screen',
      'screen',
      'screen',
      'screen',
      'screen',
      'screen',
    ];
    final titlesList1 = <String>[
      AppStrings.dayWheel,
      AppStrings.ihdaa,
      AppStrings.aboutApp,
      AppStrings.shareApp,
      AppStrings.rateUs,
      AppStrings.settings,
    ];
    final iconsList1 = <String>[
      ImageAssets.dayWheel,
      ImageAssets.ihdaa,
      ImageAssets.about,
      ImageAssets.share,
      ImageAssets.rating,
      ImageAssets.settings,
    ];
    final routesList1 = <String>[
      Routes.dayWheelRoute,
      Routes.ihdaaRoute,
      Routes.contactViewRoute,
      Routes.hesnMuslimRoute,
      Routes.dayWheelRoute,
      Routes.settingsViewRoute,
    ];
    final typesList1 = <String>[
      'screen',
      'screen',
      'screen',
      'share',
      'url',
      'screen',
    ];
    final screensList = [
      {'titles': titlesList1, 'routes': routesList1, 'icons': iconsList1,'types': typesList1},
      {'titles': titlesList2, 'routes': routesList2, 'icons': iconsList2,'types': typesList2},
    ];
    return Container(
      height: context.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: AppSize.s20,
            ),
            Center(
              child: SizedBox(
                width: context.height * 0.35,
                child: Lottie.asset(JsonAssets.homeAvatar),
              ),
            ),
            Text(
              AppStrings.homeTitle,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     scheduleNotification(
            //       id: 10, // Unique ID for this notification
            //       title: 'Scheduled e',
            //       body: 'This is a ee ',
            //       scheduledTime: tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
            //       channelName: 'Scheduled ee',
            //     );
            //   },
            //   child: Text('Schedule Notification'),
            // ),

            const SizedBox(height: AppSize.s10),
            CarouselSlider.builder(
              itemCount: screensList.length,
              itemBuilder: (ctx, index, realIdx) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: buildContainerScreen(
                      screensList[index]['titles'],
                      screensList[index]['icons'],
                      screensList[index]['routes'],
                      screensList[index]['types'],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: context.height * 0.32,
                initialPage: 1,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            //const SizedBox(height: AppSize.s16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                screensList.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeIndex == index
                        ? AppColors.primary
                        : Colors.grey[400],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s50),
          ],
        ),
      ),
    );
  }

  Container buildContainerScreen(titlesList, iconsList, routesList,typesList) {
    return Container(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.expansion,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppPadding.p8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 5 / 4.3,
              crossAxisSpacing: AppSize.s12, // افقي
              mainAxisSpacing: AppSize.s20, // رأسي
            ),
            itemCount: titlesList.length,
            itemBuilder: (context, index) {
              return HomeBoxWidget2(
                title: titlesList[index],
                imagePath: iconsList[index],
                route: routesList[index],
                type: typesList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
