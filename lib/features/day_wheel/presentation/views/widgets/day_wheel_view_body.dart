import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

class DayWheelViewBody extends StatefulWidget {
  const DayWheelViewBody({Key? key}) : super(key: key);

  @override
  State<DayWheelViewBody> createState() => _DayWheelViewBodyState();
}

class _DayWheelViewBodyState extends State<DayWheelViewBody> {
  StreamController<int>? controller;

  List<String> fortuneTitles = const [
    'صلاة ركعتين شكر',
    'تصدق (١ - ٥ جنيه)',
    '١٠٠ استغفار',
    '١٠٠ صلاة علي النبي',
    '١٠٠ سبحان الله',
    '١٠٠ الحمد لله',
    '١٠٠ الله أكبر',
    'قراءة ٥٠ آية',
    'الدعاء ل ١٠ أصدقاء',
  ];

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>.broadcast();
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }

  bool isEnd = false;

  @override
  Widget build(BuildContext context) {
    List<FortuneItem> fortuneItems = [
      wheelItem('صلاة ركعتين شكر'),
      wheelItem('تصدق (١ - ٥ جنيه)'),
      wheelItem('١٠٠ استغفار'),
      wheelItem('١٠٠ صلاة علي النبي'),
      wheelItem('١٠٠ سبحان الله'),
      wheelItem('١٠٠ الحمد لله'),
      wheelItem('١٠٠ الله أكبر'),
      wheelItem('قراءة ٥٠ آية'),
      wheelItem('الدعاء ل ١٠ أصدقاء'),
    ];
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              padding: const EdgeInsets.all(AppPadding.p28),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImageAssets.dayWheelBorder,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              child: FortuneWheel(
                selected: controller!.stream,
                animateFirst: false,
                physics: CircularPanPhysics(
                  duration: const Duration(seconds: AppConstants.dayWheelSpeed),
                  curve: Curves.decelerate,
                ),
                onFling: () {
                  controller!.add(Random().nextInt(fortuneItems.length));
                },
                indicators: <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      ImageAssets.dayWheelMark,
                      width: AppSize.s40,
                    ),
                  ),
                ],
                onAnimationEnd: () {
                  setState(() {
                    isEnd = true;
                  });
                },
                onAnimationStart: () {
                  setState(() {
                    isEnd = false;
                  });
                },
                items: fortuneItems,
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s50,
            width: AppSize.s300,
            child: StreamBuilder(
              stream: controller!.stream,
              builder: (context, snapshot) => snapshot.hasData && isEnd
                  ? dayWheelChoice(snapshot)
                  : Container(),
            ),
          ),
          const SizedBox(
            height: AppSize.s100,
          ),
        ],
      ),
    );
  }

  FortuneItem wheelItem(String title){
    return FortuneItem(child: Text(title,style: const TextStyle(
      fontSize: FontSize.s14,
      fontFamily: FontConstants.fontFamily,
    ),));
  }
  Widget dayWheelChoice(var snapshot) {
    var index = snapshot.data.toString();
    String text = fortuneTitles[int.parse(index)];
    return Container(alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.thirdColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s10)
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize: FontSize.s25,
          fontWeight: FontWeightManager.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
