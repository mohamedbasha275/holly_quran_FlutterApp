import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';
import 'package:holly_quran/features/home/presentation/view_models/quran/quran_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/surah_widget.dart';
import 'package:quran/quran.dart' as quran;

class QuranViewBody extends StatelessWidget {
  const QuranViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child:  BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppSize.s10),
                  SizedBox(
                    height: AppSize.s150,
                    width: context.width,
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(Routes.surahDetailsRoute,extra: state.sours[state.stopSurah-1]);
                      },
                      child: Card(
                        elevation: AppSize.s4,
                        color: AppColors.primary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(ImageAssets.quranStop,
                                    width: AppSize.s50),
                                const SizedBox(width: AppSize.s10),
                                Text(AppStrings.stopReading,
                                    style:
                                    Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                            Text(
                              '${AppStrings.stopAya} ( ${arNumber('${state.stopAya}')} ) ${AppStrings.stopSurah}  ${quran.getSurahNameArabic(state.stopSurah)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                fontSize: FontSize.s14,
                              ),
                            ),
                            const SizedBox(height: AppSize.s4),
                            Text(
                              AppStrings.completeReading,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                fontSize: FontSize.s12,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(AppPadding.p8),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 10 / 2,
                      // crossAxisSpacing: AppSize.s12, // افقي
                      //mainAxisSpacing: AppSize.s20, // رأسي
                    ),
                    itemCount: state.sours.length,
                    itemBuilder: (context, index) =>
                        SurahWidget(surah: state.sours[index]),
                  ),
                ],
              ),
            );
          } else {
            return StateRender.fullLoadingScreenImage;
          }
        },
      ),
    );
  }
}
