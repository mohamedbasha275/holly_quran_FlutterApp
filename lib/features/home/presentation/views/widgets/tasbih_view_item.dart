import 'package:flutter/material.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/common_widgets/quran_app_bar.dart';
import 'package:holly_quran/features/home/data/models/tasbih/tasbih_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';

class TasbihViewItem extends StatefulWidget {
  final String name;
  final int counter;

  const TasbihViewItem({Key? key, required this.name, required this.counter})
      : super(key: key);

  @override
  State<TasbihViewItem> createState() => _TasbihViewItemState();
}

class _TasbihViewItemState extends State<TasbihViewItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool vibStatus = false;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: AppConstants.tasbihSpeedTime),
      vsync: this,
    );
    _vib();
    super.initState();
  }
  Future<void> _vib() async{
    var appPreferences = getIt.get<AppPreferences>();
    vibStatus = await appPreferences.getVibrateStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double end = 0;
  int counter = 0;
  int cycle = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s50),
          child: QuranAppBar(title: widget.name),
        ),
        body: Container(
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            end = 0;
                            counter = 0;
                            cycle = 0;
                          });
                          _controller.reset();
                        },
                        icon: Icon(
                          Icons.restart_alt,
                          color: AppColors.reset,
                          size: 50,
                        ),
                      ),
                      Container(
                        width: context.width * 0.75,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.thirdColor,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: context.width * 0.48,
                              child: Text(
                                widget.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: FontSize.s20,
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'الهدف : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontSize: FontSize.s16,
                                              color: AppColors.expansion),
                                    ),
                                    Text(
                                      '${widget.counter}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontSize: FontSize.s16,
                                              color: AppColors.expansion),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'الدورات : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontSize: FontSize.s16,
                                              color: AppColors.expansion),
                                    ),
                                    Text(
                                      '${cycle}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontSize: FontSize.s16,
                                              color: AppColors.expansion),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // ElevatedButton(
                  //   onPressed: () async{
                  //     await flutterTts.setLanguage('ar');
                  //     var voices = await flutterTts.getVoices;
                  //     await flutterTts.setVoice({"name": "ar-xa-x-ard-local", "locale": "ar"});
                  //     var maleVoice = voices.firstWhere(
                  //           (voice) => voice.toString().toLowerCase().contains('male'),
                  //       orElse: () => null,
                  //     );
                  //     print(voices);
                  //     flutterTts.speak(widget.name);
                  //   },
                  //   child: Text('Speak'),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      left: AppMargin.m50,
                      right: AppMargin.m50,
                    ),
                    // height: AppSize.s390,
                    // width: AppSize.s390,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        RotationTransition(
                          turns:
                              Tween(begin: 0.0, end: end).animate(_controller),
                          child: Image.asset(
                            ImageAssets.tasbihCounter,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: AppSize.s50,
                          height: AppSize.s40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.expansion,
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          child: Text(
                            '$counter',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    fontSize: FontSize.s20,
                                    color: Colors.black54),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 62.0,
                    lineWidth: 10.0,
                    // animation: true,
                    //percent: counter < 99 ? double.parse('${counter / 100}') : 1,
                    percent: double.parse('${counter / widget.counter}'),
                    center: SizedBox(
                      width: AppSize.s100,
                      height: AppSize.s100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.primary,
                          ),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                        ),
                        onPressed: () async {
                          setState(() {
                            end += 0.01;
                            counter += 1;
                          });
                          _controller.forward();
                          //
                          if (counter == widget.counter) {
                            if(vibStatus){
                              Vibration.vibrate(duration: 100);
                            }
                            setState(() {
                              end = 0;
                              counter = 0;
                              cycle += 1;
                            });
                            _controller.reset();
                          } else {
                            if(vibStatus){
                              print('ff');
                              Vibration.vibrate(duration: 20);
                            }
                          }
                        },
                        child: Text(
                          '',
                          //AppStrings.tasbihCounter,
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.purple,
                  ),
                  const SizedBox(height: AppSize.s14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
