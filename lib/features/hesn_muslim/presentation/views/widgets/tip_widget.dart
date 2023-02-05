import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/hadith/data/models/hadith_model.dart';

class TipWidget extends StatelessWidget {
  final String tip;
  const TipWidget({required this.tip, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
       children: [
         Row(
           children: [
             Expanded(
               child: Text(tip, style: Theme.of(context).textTheme.headlineLarge),
             )
           ],
         ),
         Divider(color: AppColors.primary),
       ],
     );
  }
}
