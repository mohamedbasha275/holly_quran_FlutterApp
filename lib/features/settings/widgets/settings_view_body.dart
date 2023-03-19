import 'package:flutter/material.dart';
import 'package:holly_quran/core/app_notifications.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/common_widgets/show_snackBar.dart';
import 'package:intl/intl.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  _SettingsViewBodyState createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  AppPreferences appPreferences = getIt.get<AppPreferences>();
  late TimeOfDay? sabahPicked;
  late TimeOfDay? masaaPicked;
  late TimeOfDay? werdPicked;
  late DateTime _sabahSelectedTime = DateTime.now();
  late DateTime _masaaSelectedTime = DateTime.now();
  late DateTime _werdSelectedTime = DateTime.now();
  bool activeStatus = true;

  // get time from shared
  Future<void> _loadSelectedTime() async {
    final now = DateTime.now();
    List<int> sabahTimes = await appPreferences.getAzkarSabah();
    List<int> masaaTimes = await appPreferences.getAzkarMasaa();
    List<int> werdTimes = await appPreferences.getAzkarWerd();
    bool notfStatus = await appPreferences.getNotificationsStatus();
    setState(() {
      _sabahSelectedTime = DateTime(now.year, now.month, now.day, sabahTimes[0], sabahTimes[1]);
      _masaaSelectedTime = DateTime(now.year, now.month, now.day, masaaTimes[0], masaaTimes[1]);
      _werdSelectedTime = DateTime(now.year, now.month, now.day, werdTimes[0], werdTimes[1]);
      sabahPicked = TimeOfDay.fromDateTime(_sabahSelectedTime);
      masaaPicked = TimeOfDay.fromDateTime(_masaaSelectedTime);
      werdPicked = TimeOfDay.fromDateTime(_werdSelectedTime);
      activeStatus = notfStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSelectedTime();
  }

  void _showSettingsViewBody(
    BuildContext context, {
    required TimeOfDay? picked,
    required DateTime selectedTime,
    required void Function(DateTime) onTimeSelected,
  }) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: picked ?? TimeOfDay.now(),
    );
    if (newTime != null) {
      final DateTime newDateTime = DateTime(selectedTime.year,
          selectedTime.month, selectedTime.day, newTime.hour, newTime.minute);
      onTimeSelected(newDateTime);
      fireAppNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(AppMargin.m20),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    activeStatus = !activeStatus;
                    appPreferences.setNotificationsStatus(status: activeStatus).then((_){
                      String title = activeStatus ?  AppStrings.activeNotifications : AppStrings.disActiveNotifications;
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(
                          context,
                          title: "${AppStrings.done} $title ${AppStrings.successfully}",
                          background: AppColors.primary,
                        ),
                      );
                    });
                  });
                },
                child: SizedBox(
                  height: AppSize.s80,
                  child: Card(
                    color: AppColors.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            activeStatus ?  AppStrings.disActiveNotifications : AppStrings.activeNotifications,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Icon(activeStatus ? Icons.notifications : Icons.notifications_off),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _showSettingsViewBody(context,
                        picked: sabahPicked,
                        selectedTime: _sabahSelectedTime, onTimeSelected: (newTime) {
                          setState(() {
                            _sabahSelectedTime = newTime;
                            appPreferences.setAzkarSabah(
                                hour: newTime.hour, minute: newTime.minute);
                            sabahPicked = TimeOfDay.fromDateTime(newTime);
                          });
                        }),
                    child: SizedBox(
                    height: AppSize.s150,
                    width: AppSize.s150,
                    child: Card(
                      color: AppColors.expansion,
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              AppStrings.azkarSabah,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              arTime(DateFormat('h:mm a')
                                  .format(_sabahSelectedTime)),
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                  GestureDetector(
                    onTap: () => _showSettingsViewBody(context,
                        picked: masaaPicked,
                        selectedTime: _masaaSelectedTime, onTimeSelected: (newTime) {
                          setState(() {
                            _masaaSelectedTime = newTime;
                            appPreferences.setAzkarMasaa(
                                hour: newTime.hour, minute: newTime.minute);
                            masaaPicked = TimeOfDay.fromDateTime(newTime);
                          });
                        }),
                    child: SizedBox(
                      height: AppSize.s150,
                      width: AppSize.s150,
                      child: Card(
                        color: AppColors.expansion,
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                AppStrings.azkarMasaa,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                arTime(DateFormat('h:mm a').format(_masaaSelectedTime)),
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s20),
              Container(
                margin: const EdgeInsets.only(right: AppPadding.p10),
                child: Row(
                 //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => _showSettingsViewBody(context,
                          picked: werdPicked,
                          selectedTime: _werdSelectedTime, onTimeSelected: (newTime) {
                            setState(() {
                              _werdSelectedTime = newTime;
                              appPreferences.setAzkarWerd(
                                  hour: newTime.hour, minute: newTime.minute);
                              werdPicked = TimeOfDay.fromDateTime(newTime);
                            });
                          }),
                      child: SizedBox(
                        height: AppSize.s150,
                        width: AppSize.s150,
                        child: Card(
                          color: AppColors.expansion,
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  AppStrings.werdDay,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  arTime(DateFormat('h:mm a').format(_werdSelectedTime)),
                                  style: Theme.of(context).textTheme.titleMedium,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () => _showSettingsViewBody(context,
                    //       picked: sabahPicked,
                    //       selectedTime: _sabahSelectedTime, onTimeSelected: (newTime) {
                    //         setState(() {
                    //           _sabahSelectedTime = newTime;
                    //           appPreferences.setAzkarSabah(
                    //               hour: newTime.hour, minute: newTime.minute);
                    //           sabahPicked = TimeOfDay.fromDateTime(newTime);
                    //         });
                    //       }),
                    //   child: SizedBox(
                    //     height: 150,
                    //     width: 150,
                    //     child: Card(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           children: [
                    //             Text(
                    //               'اذكار الصباح',
                    //               style: const TextStyle(fontSize: 24.0),
                    //             ),
                    //             Text(
                    //               DateFormat('h:mm a').format(_sabahSelectedTime),
                    //               style: const TextStyle(fontSize: 24.0),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
