import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/styles_manager.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

class FullLoadingScreen extends StatelessWidget {
  const FullLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getItemsColumn([
      _getSmallImage(ImageAssets.quran),
      _getMessage(AppStrings.loading),
    ]);
  }
}

Widget _getItemsColumn(List<Widget> children) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children,
  );
}

Widget _getAnimatedImage(String animationName) {
  return SizedBox(
    height: AppSize.s100,
    width: AppSize.s100,
    child: Lottie.asset(animationName),
  );
}

Widget _getSmallImage(String imagePath) {
  return SizedBox(
    height: AppSize.s100,
    width: AppSize.s100,
    child: Image.asset(imagePath),
  );
}

Widget _getMessage(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        message,
        style: getRegularStyle(
          color: AppColors.black,
          fontSize: FontSize.s18,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
