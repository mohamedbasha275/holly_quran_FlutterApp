import 'dart:async';
import 'dart:math';
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

  List<FortuneItem> fortuneItems = const [
    FortuneItem(child: Text('صلاة ركعتين شكر')),
    FortuneItem(child: Text('تصدق (١ - ٥ جنيه)')),
    FortuneItem(child: Text('١٠٠ استغفار')),
    FortuneItem(child: Text('١٠٠ صلاة علي النبي')),
    FortuneItem(child: Text('١٠٠ سبحان الله')),
    FortuneItem(child: Text('١٠٠ الحمد لله')),
    FortuneItem(child: Text('١٠٠ الله أكبر')),
    FortuneItem(child: Text('قراءة ٥٠ آية')),
    FortuneItem(child: Text('الدعاء ل ١٠ أصدقاء')),
  ];
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

  Widget dayWheelChoice(var snapshot) {
    var index = snapshot.data.toString();
    String text = fortuneTitles[int.parse(index)];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s10)
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize: FontSize.s20,
          fontWeight: FontWeightManager.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
