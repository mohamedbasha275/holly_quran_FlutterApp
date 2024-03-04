import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/salah/salah_cubit.dart';

class SalahWidget extends StatelessWidget {
  final SalahModel salah;
  final bool isNext;

  const SalahWidget({required this.salah, required this.isNext, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dt1 = DateTime.now();
    DateTime dt2 = salah.dateTime;
    Duration diff = dt2.difference(dt1);
    int hours = diff.inHours;
    int minutes = diff.inMinutes % 60; // للحصول على الدقائق المتبقية بعد حساب الساعات
    int seconds = diff.inSeconds % 60; // للحصول على الثواني المتبقية بعد حساب الدقائق

    Color color = (isNext) ? AppColors.white : AppColors.black;
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      decoration: BoxDecoration(
        color: (isNext) ? AppColors.secondary : AppColors.expansion,
        borderRadius: BorderRadius.circular(AppSize.s100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(salah.icon, color: color),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Text(
                  salah.name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: color,
                      ),
                ),
              ],
            ),
            Text(
              "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: color, fontSize: FontSize.s14),
            ),
            Text(
              arTime(salah.time),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: color, fontSize: FontSize.s14),
            ),
          ],
        ),
      ),
    );
  }
}
