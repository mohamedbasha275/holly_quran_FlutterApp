import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/azkar_sabah/data/azkar_sabah_data.dart';
import 'package:holly_quran/features/azkar_sabah/presentation/views/widgets/azkar_sabah_widget.dart';

class AzkarSabahViewBody extends StatelessWidget {
  const AzkarSabahViewBody({Key? key}) : super(key: key);

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
          itemCount: azkarList.length,
          itemBuilder: (context, index) => AzkarSabahWidget(azkar: azkarList[index]),
        ),
      ),
    );
  }
}
