import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/common_widgets/show_snackBar.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/quran/quran_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/soura_stack_widget.dart';

class SurahViewBody extends StatefulWidget {
  final SurahModel surah;
  final int stopPage;

  const SurahViewBody({required this.surah, required this.stopPage, Key? key})
      : super(key: key);

  @override
  State<SurahViewBody> createState() => _SurahViewBodyState();
}

class _SurahViewBodyState extends State<SurahViewBody> {
  late final PageController boardController;
  late final List<String> pages;
  bool _showWidget = false;
  int _currentPage = 1;
  AppPreferences appPreferences = getIt.get<AppPreferences>();

  @override
  void initState() {
    super.initState();
    boardController = PageController(initialPage: widget.stopPage - 1);
    pages = BlocProvider.of<QuranCubit>(context).quranPages;
    setState(() {
      _currentPage = widget.stopPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showWidget = !_showWidget;
        });
        Future.delayed(const Duration(seconds: AppConstants.souraAppBarView),
            () {
          setState(() {
            _showWidget = false;
          });
        });
      },
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: boardController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index + 1;
              });
            },
            allowImplicitScrolling: false,
            itemBuilder: (context, index) {
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  pages[index],
                  fit: BoxFit.fill,
                ),
              );
            },
            itemCount: pages.length,
          ),
          _showWidget
              ? SouraStackWidget(
                  functionMark: () {
                    String surah = BlocProvider.of<QuranCubit>(context)
                        .getCurrentSouraName(page: _currentPage);
                    appPreferences.setStopReading(
                      surah: widget.surah.id,
                      page: _currentPage,
                      surahName: surah,
                      //surahName: soura.name,
                    );
                    BlocProvider.of<QuranCubit>(context).fetchQuran();
                    ScaffoldMessenger.of(context).showSnackBar(
                      buildSnackBar(context, title: AppStrings.markStop,background: AppColors.primary,),
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
