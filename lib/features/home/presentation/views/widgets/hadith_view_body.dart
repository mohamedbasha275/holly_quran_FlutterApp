import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

class HadithViewBody extends StatelessWidget {
  const HadithViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: AppSize.s300,
              child: Text('JsonAssets.homeAvatar'),
            ),
          ),
        ],
      ),
    );
  }
}
