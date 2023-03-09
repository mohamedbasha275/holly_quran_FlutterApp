import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/quran_app_bar.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/surah_view_body.dart';
import 'package:holly_quran/features/quran_agzaa/presentation/views/widgets/juzh_view_body.dart';

class JuzhView extends StatelessWidget {
  final String startPage;
  //final String endPage;
 // const JuzhView({super.key, required this.startPage, required this.endPage});
  const JuzhView({super.key, required this.startPage});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s0),
          child: QuranAppBar(title: ""),
        ),
        //body: JuzhViewBody(startPage: int.parse(startPage),endPage: int.parse(endPage)),
        body: JuzhViewBody(startPage: int.parse(startPage)),
      ),
    );
  }
}
