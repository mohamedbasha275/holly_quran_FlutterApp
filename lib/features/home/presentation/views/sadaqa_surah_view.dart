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
  const SadaqaSurahView({super.key, required this.name,required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    //print(quran.getPageData(pageNumber));
    int pageNum = int.parse(pageNumber);
    int surahNumber = quran.getPageData(pageNum)[0]['surah'];
    int start = quran.getPageData(pageNum)[0]['start'];
    int end = quran.getPageData(pageNum)[0]['end'];
    print('object:$pageNum');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s50),
          child: QuranAppBar(title: name),
        ),
        body: Container(
          padding: const EdgeInsets.all(AppPadding.p6),
          height: context.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.background),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      for (int i = start; i <= end; i++)
                        TextSpan(
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: FontSize.s25,
                          ),
                          text: "${quran.getVerse(surahNumber, i)} "
                              "${quran.getVerseEndSymbol(i)} ",
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
