import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/features/quran_agzaa/presentation/views/widgets/quran_agzaa_view_body.dart';

class QuranAgzaaView extends StatelessWidget {
  const QuranAgzaaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s50),
          child: MyAppBar(title: AppStrings.quranAgzaa),
        ),
        body: QuranAgzaaViewBody(),
      ),
    );
  }
}
