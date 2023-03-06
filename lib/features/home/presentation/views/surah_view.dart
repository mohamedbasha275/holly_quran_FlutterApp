import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/quran_app_bar.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/surah_view_body.dart';

class SurahView extends StatelessWidget {
  final SurahModel surah;
  final String stopPage;
  const SurahView({super.key, required this.surah, required this.stopPage});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s0),
          child: QuranAppBar(title: "${AppStrings.soura} ${surah.name}"),
        ),
        body: SurahViewBody(surah: surah,stopPage: int.parse(stopPage)),
      ),
    );
  }
}
