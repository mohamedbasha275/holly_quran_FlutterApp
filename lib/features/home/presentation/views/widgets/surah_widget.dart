import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';

class SurahWidget extends StatelessWidget {
  final SurahModel surah;

  const SurahWidget({required this.surah, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(Routes.surahDetailsRoute,extra: surah);
      },
      child: Container(
        margin: const EdgeInsets.only(top: AppMargin.m8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: AppSize.s50,
                      height: AppSize.s50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageAssets.star),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text(
                        arNumber("${surah.id}"),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: FontSize.s16),
                      ),
                    ),
                    const SizedBox(width: AppSize.s10),
                    Text(
                      surah.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(surah.type),
                    Row(
                      children: [
                        Text(arNumber("${surah.ayatNumber}")),
                        const SizedBox(
                          width: AppSize.s4,
                        ),
                        const Text(AppStrings.aya),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
