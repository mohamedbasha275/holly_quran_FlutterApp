import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';
import 'package:holly_quran/features/home/presentation/view_models/salah/salah_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/salah_widget.dart';

class SalahViewBody extends StatelessWidget {
  const SalahViewBody({Key? key}) : super(key: key);

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSize.s10),
            Card(
              elevation: AppSize.s4,
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Row(
                  children: [
                    Image.asset(ImageAssets.mosque, width: AppSize.s80),
                    const SizedBox(width: AppSize.s10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_month, color: AppColors.white),
                            const SizedBox(width: AppSize.s10),
                            Text(
                              '${getHijriDate()} ${AppStrings.hijriLetter}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        BlocBuilder<SalahCubit, SalahState>(
                          builder: (context, state) {
                            if(state is SalahSuccess){
                              return Row(
                                children: [
                                  Icon(Icons.timer_sharp, color: AppColors.white),
                                  const SizedBox(width: AppSize.s10),
                                  Text(AppStrings.nextSalah,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                      fontSize: FontSize.s16,
                                    ),
                                  ),
                                  Text(state.salah[state.nextSalahId].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                      fontSize: FontSize.s16,
                                    ),
                                  ),
                                ],
                              );
                            }else{
                              return const Text('');
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                await BlocProvider.of<SalahCubit>(context).updateLocation();
              },
              label: Text(AppStrings.refreshLocation,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              icon: Icon(Icons.location_on,color: AppColors.white),
              backgroundColor: AppColors.primarySwatch,
              shape: StadiumBorder(),
            ),
            BlocBuilder<SalahCubit, SalahState>(
              builder: (context, state) {
                if (state is SalahSuccess) {
                  return SizedBox(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 10 / 2.1,
                        ),
                        //itemCount: state.sours.length,
                        itemCount: state.salah.length,
                        itemBuilder: (context, index){
                          bool isNext = (index == state.nextSalahId)? true : false;
                          return SalahWidget(salah: state.salah[index],isNext: isNext);
                        },
                      ),
                    ),
                  );
                } else if(state is SalahLoading){
                  return const FullLoadingScreenAnimated(message: AppStrings.getLocation);
                }else {
                  return StateRender.fullLoadingScreenImage;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
