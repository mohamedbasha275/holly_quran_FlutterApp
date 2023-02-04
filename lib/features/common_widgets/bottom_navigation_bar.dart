import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/presentation/view_models/botoom_navBae/bottom_nav_bar_cubit.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final BottomNavBarCubit cubit;
  final BottomNavBarState state;
  const AppBottomNavigationBar({required this.cubit,required this.state,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final navBarIcons = <String>[
      ImageAssets.quran,
      ImageAssets.sadqat,
      ImageAssets.tasbih,
      ImageAssets.salah,
    ];
    final navBarTitles = <String>[
      AppStrings.quran,
      AppStrings.sadqat,
      AppStrings.tasbih,
      AppStrings.salah,
    ];
    return AnimatedBottomNavigationBar.builder(
      height: AppSize.s100,
      itemCount: cubit.allItemsCount - 1,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? AppColors.secondary : AppColors.white;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(navBarIcons[index],width: AppSize.s60),
            const SizedBox(height: AppSize.s4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Text(
                navBarTitles[index],
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: color,
                ),
                // group: autoSizeGroup,
              ),
            )
          ],
        );
      },
      backgroundColor: AppColors.primary,
      activeIndex: cubit.currentIndex,
      splashSpeedInMilliseconds: AppConstants.bottomNavSpeedTime,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: AppSize.s32,
      rightCornerRadius: AppSize.s32,
      onTap: (index) {
        cubit.changeIndex(index: index);
      },
    );
  }
}
