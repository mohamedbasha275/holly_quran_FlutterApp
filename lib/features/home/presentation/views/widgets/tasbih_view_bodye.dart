import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

class TasbihViewBody extends StatefulWidget {
  const TasbihViewBody({Key? key}) : super(key: key);

  @override
  State<TasbihViewBody> createState() => _TasbihViewBodyState();
}

class _TasbihViewBodyState extends State<TasbihViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: AppConstants.tasbihSpeedTime),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double end = 0;
  int counter = 0;

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
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top:AppMargin.m50,left:AppMargin.m50,right:AppMargin.m50,),
                height: AppSize.s390,
                width: AppSize.s390,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: end).animate(_controller),
                      child: Image.asset(
                        ImageAssets.tasbihCounter,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: AppSize.s230,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.expansion,
                        borderRadius: BorderRadius.circular(AppSize.s20)
                      ),
                      child: Text('$counter', style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: FontSize.s50),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: AppSize.s230,
                height: AppSize.s80,
                child: ElevatedButton(
                  child: const Text(AppStrings.tasbihCounter),
                  onPressed: () {
                    setState(() {
                      end += 0.01;
                      counter += 1;
                    });
                    _controller.forward();
                  },
                ),
              ),
              const SizedBox(height: AppSize.s14),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: AppPadding.p14,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.reset
                  ),
                ),
                onPressed: () {
                  setState(() {
                    end = 0;
                    counter = 0;
                  });
                  _controller.reset();
                },
                child: const Text(AppStrings.tasbihReset),
              ),
              const SizedBox(height: AppSize.s40),
            ],
          ),
        ),
      ),
    );
  }
}
