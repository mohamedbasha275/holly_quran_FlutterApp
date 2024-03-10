import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/salah/salah_cubit.dart';

class SalahWidget extends StatefulWidget {
  final SalahModel salah;
  final bool isNext;

  const SalahWidget({required this.salah, required this.isNext, Key? key})
      : super(key: key);

  @override
  State<SalahWidget> createState() => _SalahWidgetState();
}

class _SalahWidgetState extends State<SalahWidget> {

  Timer? timer;

  @override
  void initState() {
    super.initState();
    // تشغيل تايمر يتحدث كل ثانية
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => setState(() {}));
  }

  @override
  void dispose() {
    timer?.cancel(); // إيقاف التايمر عند إزالة الويدجت من الشجرة
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // DateTime dt1 = DateTime.now();
    // DateTime dt2 = widget.salah.dateTime;
    // Duration diff = dt2.difference(dt1);
    // int hours = diff.inHours;
    // int minutes = diff.inMinutes % 60; // للحصول على الدقائق المتبقية بعد حساب الساعات
    // int seconds = diff.inSeconds % 60; // للحصول على الثواني المتبقية بعد حساب الدقائق
    DateTime now = DateTime.now();
    DateTime salahTime = widget.salah.dateTime;
    // تحقق إذا كان وقت الصلاة قد مضى
    if (now.isAfter(salahTime)) {
      salahTime = salahTime.add(Duration(days: 1)); // إضافة يوم واحد للوصول لفجر اليوم التالي
    }

    Duration difference = salahTime.difference(now);
    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60; // للحصول على الثواني المتبقية


    Color color = (widget.isNext) ? Colors.blueGrey : AppColors.black;
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      decoration: BoxDecoration(
        color: (widget.isNext) ? AppColors.secondary : AppColors.expansion,
        borderRadius: BorderRadius.circular(AppSize.s100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(widget.salah.icon, color: color),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Text(
                  widget.salah.name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: color,
                      ),
                ),
              ],
            ),
            if(widget.isNext)
            Row(
              children: [
                Text('متبقي: ', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: color,
                  fontSize: 12,
                ),),
                Text(
                //   "${hours.toString().padLeft(2, '0')} س : ${minutes.toString().padLeft(2, '0')} د",
                //   style: Theme.of(context)
                //       .textTheme
                //       .titleSmall!
                //       .copyWith(color: color, fontSize: FontSize.s14),
                // ),
                  "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: color, fontSize: FontSize.s14),
                ),
              ],
            ),
            Text(
              arTime(widget.salah.time),
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
