import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/hadith/data/hadith_data.dart';
import 'package:holly_quran/features/hadith/presentation/views/widgets/hadith_widget.dart';

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
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppPadding.p8),
          itemCount: hadithList.length,
          itemBuilder: (context, index) => HadithWidget(hadith: hadithList[index]),
        ),
      ),
    );
  }
}
