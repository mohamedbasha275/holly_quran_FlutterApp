import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/azkar/data/azkar_sabah_data.dart';
import 'package:holly_quran/features/azkar/presentation/views/widgets/azkar_view_body.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';

class AzkarSabahView extends StatelessWidget {
  const AzkarSabahView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s50),
          child: MyAppBar(title: AppStrings.azkarSabah),
        ),
        body: AzkarViewBody(azkarList: azkarSabahList),
      ),
    );
  }
}
