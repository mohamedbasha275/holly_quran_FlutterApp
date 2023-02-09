import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/styles_manager.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

abstract class StateRender{
  static Widget fullLoadingScreenImage = const FullLoadingScreenImage();
}
class FullLoadingScreenImage extends StatelessWidget {
  final String message;
  const FullLoadingScreenImage({this.message=AppStrings.loading,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _getItemsColumn([
      _getSmallImage(ImageAssets.quran),
      _getMessage(message),
    ]);
  }
}

class FullLoadingScreenAnimated extends StatelessWidget {
  final String message;
  const FullLoadingScreenAnimated({this.message=AppStrings.loading,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _getItemsColumn([
      const SizedBox(height: AppSize.s80),
      _getAnimatedImage(JsonAssets.salahAvatar),
      _getMessage(message),
    ]);
  }
}

Widget _getSmallImage(String imagePath) {
  return SizedBox(
    height: AppSize.s100,
    width: AppSize.s100,
    child: Image.asset(imagePath),
  );
}

Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14)),
    elevation: AppSize.s1_5,
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)]),
      child: _getDialogContent(context, children),
    ),
  );
}

Widget _getDialogContent(BuildContext context, List<Widget> children) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children,
  );
}

Widget _getItemsColumn(List<Widget> children) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ),
  );
}

Widget _getAnimatedImage(String animationName) {
  return SizedBox(
      height: AppSize.s200,
      width: AppSize.s200,
      child: Lottie.asset(animationName));
}

Widget _getMessage(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        message,
        style: getRegularStyle(
          color: AppColors.black, fontSize: FontSize.s18,),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _getRetryButton(String buttonTitle, BuildContext context,Function function) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: function(),
              child: Text(buttonTitle))),
    ),
  );
}
