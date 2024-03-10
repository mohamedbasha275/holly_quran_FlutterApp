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
      child: BlocBuilder<HesnCubit, HesnState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'بحث...',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: _buildHesnList(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHesnList(HesnState state) {
    if (state is HesnSuccess) {
      List<HesnModel> filteredList = state.hesnList
          .where((hesn) =>
              hesn.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

      if (filteredList.isEmpty) {
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'لا توجد نتائج بحث',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));
      }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: ExpansionPanelList(
            elevation: AppSize.s3,

            expansionCallback: (index, isExpanded) {
              setState(() {
                filteredList[index].expanded = isExpanded;
              });
            },
            animationDuration:
                const Duration(milliseconds: AppConstants.expandSpeedTime),
            children: filteredList.map<ExpansionPanel>((HesnModel hesn) {
              return ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: hesn.expanded ? AppColors.secondary : AppColors.white,
                headerBuilder: (_, isExpanded) =>
                    HesnMuslimTitleWidget(title: hesn.title),
                body: HesnMuslimBodyWidget(tips: hesn.tips),
                isExpanded: hesn.expanded,
              );
            }).toList(),
          ),
        ),
      );
    } else {
      return StateRender.fullLoadingScreenImage;
    }
  }
}
