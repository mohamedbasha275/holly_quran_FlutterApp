import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/features/hadith/presentation/views/widgets/hadith_view_body.dart';

class HadithView extends StatelessWidget {
  const HadithView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s50),
          child: MyAppBar(title: AppStrings.hadith),
        ),
        body: HadithViewBody(),
      ),
    );
  }
}
