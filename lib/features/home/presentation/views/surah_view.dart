import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/quran_app_bar.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/surah_view_body.dart';

class SurahView extends StatelessWidget {
  final SurahModel surah;
  const SurahView({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s50),
          child: QuranAppBar(title: surah.name),
        ),
        body: SurahViewBody(surah: surah),
      ),
    );
  }
}
