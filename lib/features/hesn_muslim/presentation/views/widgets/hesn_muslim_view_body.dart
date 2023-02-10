import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';
import 'package:holly_quran/features/hesn_muslim/data/hesn_muslim_data.dart';
import 'package:holly_quran/features/hesn_muslim/data/models/hesn_model.dart';
import 'package:holly_quran/features/hesn_muslim/presentation/view_models/hesn_cubit.dart';
import 'package:holly_quran/features/hesn_muslim/presentation/views/widgets/hesn_muslim_body_widget.dart';
import 'package:holly_quran/features/hesn_muslim/presentation/views/widgets/hesn_muslim_title_widget.dart';

class HesnMuslimViewBody extends StatefulWidget {
  const HesnMuslimViewBody({Key? key}) : super(key: key);

  @override
  State<HesnMuslimViewBody> createState() => _HesnMuslimViewBodyState();
}

class _HesnMuslimViewBodyState extends State<HesnMuslimViewBody> {
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
      child: BlocBuilder<HesnCubit, HesnState>(
        builder: (context, state) {
          if (state is HesnSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: ExpansionPanelList(
                  elevation: AppSize.s3,
                  expansionCallback: (index, isExpanded) {
                    setState(() {
                      state.hesnList[index].expanded = !isExpanded;
                    });
                  },
                  animationDuration: const Duration(
                      milliseconds: AppConstants.expandSpeedTime),
                  children: [
                    for (HesnModel hesn in state.hesnList)
                      ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: hesn.expanded == true
                            ? AppColors.expansion
                            : AppColors.white,
                        headerBuilder: (_, isExpanded) =>
                            HesnMuslimTitleWidget(title: hesn.title),
                        body: HesnMuslimBodyWidget(tips: hesn.tips),
                        isExpanded: hesn.expanded,
                      ),
                  ],
                ),
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
