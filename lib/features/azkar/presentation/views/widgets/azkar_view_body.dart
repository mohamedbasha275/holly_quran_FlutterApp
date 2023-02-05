import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/azkar/data/models/azkar_model.dart';
import 'package:holly_quran/features/azkar/presentation/views/widgets/azkar_widget.dart';

class AzkarViewBody extends StatelessWidget {
  final List<AzkarModel> azkarList;
  const AzkarViewBody({required this.azkarList,Key? key}) : super(key: key);
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
          itemBuilder: (context, index) => AzkarWidget(azkar: azkarList[index]),
        ),
      ),
    );
  }
}
