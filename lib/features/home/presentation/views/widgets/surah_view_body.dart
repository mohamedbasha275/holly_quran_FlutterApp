import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/common_widgets/show_snackBar.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/quran/quran_cubit.dart';
import 'package:quran/quran.dart' as quran;

class SurahViewBody extends StatefulWidget {
  final SurahModel surah;

  const SurahViewBody({required this.surah, Key? key}) : super(key: key);

  @override
  State<SurahViewBody> createState() => _SurahViewBodyState();
}

class _SurahViewBodyState extends State<SurahViewBody> {
  int stopSurah = 1;
  int stopAya = 1;
  Color color = AppColors.black;

  Future<void> _bend() async{
    AppPreferences appPreferences = getIt.get<AppPreferences>();
    List<String> stop = await appPreferences.getStopReading();
    setState(() {
      stopSurah = int.parse(stop[0]);
      stopAya = int.parse(stop[1]);
    });
  }
  @override
  void initState() {
    _bend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppPreferences appPreferences = getIt.get<AppPreferences>();
    print(stopSurah);
    return Container(
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
            if (widget.surah.id != 9)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Text(
                  quran.basmala,
                  style:
                      TextStyle(color: AppColors.black, fontSize: FontSize.s25),
                ),
              ),
            RichText(
              text: TextSpan(
                children: [
                  for (int i = 1; i <= widget.surah.ayatNumber; i++)
                    TextSpan(
                      style: TextStyle(
                        color: (stopSurah == widget.surah.id && stopAya == i)? AppColors.reset : color,
                        fontSize: FontSize.s25,
                      ),
                      text: "${quran.getVerse(widget.surah.id, i)} "
                          "${quran.getVerseEndSymbol(i)} ",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          appPreferences.setStopReading(
                              surah: widget.surah.id, aya: i);
                          BlocProvider.of<QuranCubit>(context).fetchQuran();
                          ScaffoldMessenger.of(context).showSnackBar(
                            buildSnackBar(context, title: AppStrings.markStop),
                          );
                          setState(() {
                            stopSurah = widget.surah.id;
                            stopAya = i;
                          });
                        },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
