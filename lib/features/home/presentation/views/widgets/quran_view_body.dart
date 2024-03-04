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
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/quran/quran_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/surah_widget.dart';

class QuranViewBody extends StatefulWidget {
  const QuranViewBody({Key? key}) : super(key: key);

  @override
  State<QuranViewBody> createState() => _QuranViewBodyState();
}

class _QuranViewBodyState extends State<QuranViewBody> {
  String _searchQuery = '';
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
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranSuccess) {
            List<SurahModel> filteredList = state.sours
                .where((surah) => surah.name.toLowerCase().contains(_searchQuery.toLowerCase()))
                .toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppSize.s10),
                  SizedBox(
                    height: AppSize.s150,
                    width: context.width,
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(Routes.surahDetailsRoute,
                            params: {'id1': "${state.stopSurah}", 'id2': '${state.stopPage}'});
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
                              '${AppStrings.stopPage} ( ${arNumber('${state.stopPage}')} ) ${AppStrings.stopSurah} ${state.stopSurahName}',
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
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  filteredList.isNotEmpty?
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
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) =>
                        SurahWidget(surah: filteredList[index]),
                  ) : const Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
