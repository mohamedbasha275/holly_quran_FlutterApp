import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/home_box_widget.dart';
import 'package:lottie/lottie.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final titlesList = <String>[
      AppStrings.azkarSabah,
      AppStrings.azkarMasaa,
      AppStrings.hadith,
      AppStrings.hesnMuslim,
      AppStrings.dayWheel,
    ];
    final iconsList = <String>[
      ImageAssets.azkarSabah,
      ImageAssets.azkarMasaa,
      ImageAssets.hadith,
      ImageAssets.hesnMuslim,
      ImageAssets.dayWheel,
    ];
    final routesList = <String>[
      Routes.azkarSabahRoute,
      Routes.azkarMasaaRoute,
      Routes.hadithRoute,
      Routes.hesnMuslimRoute,
      Routes.dayWheelRoute,
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
            const SizedBox(height: AppSize.s32,),
            Center(
              child: SizedBox(
                width: AppSize.s300,
                child: Lottie.asset(JsonAssets.homeAvatar),
              ),
            ),
            Text(
              AppStrings.homeTitle,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: AppSize.s32),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppPadding.p8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 2.2,
                crossAxisSpacing: AppSize.s12, // افقي
                mainAxisSpacing: AppSize.s20, // رأسي
              ),
              itemCount: titlesList.length,
              itemBuilder: (context, index) => HomeBoxWidget(
                  title: titlesList[index],
                  imagePath: iconsList[index],
                  route: routesList[index]
              ),
            ),
            const SizedBox(height: AppSize.s32),
          ],
        ),
      ),
    );
  }
}
