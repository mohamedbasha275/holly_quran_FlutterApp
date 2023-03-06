import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/quran_app_bar.dart';
import 'package:quran/quran.dart' as quran;

class SadaqaSurahView extends StatelessWidget {
  final String name;
  final String pageNumber;

  const SadaqaSurahView(
      {super.key, required this.name, required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    int pageNum = int.parse(pageNumber);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s50),
          child: QuranAppBar(title: name),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            '$quranData$pageNum.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
