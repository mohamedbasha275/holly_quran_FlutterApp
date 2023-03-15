import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/features/daily_werd/presentation/views/widgets/werd_view_body.dart';

class WerdView extends StatelessWidget {
  const WerdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s50),
          child: MyAppBar(title: AppStrings.werdDay),
        ),
        body: WerdViewBody(),
      ),
    );
  }
}
