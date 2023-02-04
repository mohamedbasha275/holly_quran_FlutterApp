import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/hadith/data/models/hadith_model.dart';

class HadithWidget extends StatelessWidget {
  final HadithModel hadith;

  const HadithWidget({required this.hadith, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  width: AppSize.s50,
                  height: AppSize.s50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  child: Text(
                    "${hadith.id}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  )),
              const SizedBox(
                width: AppSize.s4,
              ),
              Expanded(
                child: Text(hadith.content,
                    style: Theme.of(context).textTheme.headlineLarge),
              )
            ],
          ),
          Divider(color: AppColors.primary),
        ],
      ),
    );
  }
}
