import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';
import 'package:holly_quran/features/quran_agzaa/presentation/view_models/agzaa_cubit.dart';
import 'package:holly_quran/features/quran_agzaa/presentation/views/widgets/juzh_widget.dart';

class QuranAgzaaViewBody extends StatelessWidget {
  const QuranAgzaaViewBody({Key? key}) : super(key: key);

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
      child: BlocBuilder<AgzaaCubit, AgzaaState>(
        builder: (context, state) {
          if (state is AgzaaSuccess) {
            var cubit = BlocProvider.of<AgzaaCubit>(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppSize.s10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(AppPadding.p8),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 10 / 2,
                    ),
                    itemCount: cubit.agzaa.length,
                    itemBuilder: (context, index) =>
                        JuzhWidget(juzh: cubit.agzaa[index]),
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
