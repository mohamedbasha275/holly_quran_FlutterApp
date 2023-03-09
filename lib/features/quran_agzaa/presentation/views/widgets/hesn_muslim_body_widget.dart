import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/hesn_muslim/data/models/hesn_tip_model.dart';
import 'package:holly_quran/features/hesn_muslim/presentation/views/widgets/tip_widget.dart';

class HesnMuslimBodyWidget extends StatelessWidget {
  final List<HesnTipModel> tips;

  const HesnMuslimBodyWidget({required this.tips, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        itemCount: tips.length,
        itemBuilder: (context, index) => TipWidget(tip: tips[index].content),
      ),
    );
  }
}
