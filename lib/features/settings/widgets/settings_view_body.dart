import 'package:flutter/material.dart';
import 'package:holly_quran/core/app_notifications.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
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
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    activeStatus = !activeStatus;
                    appPreferences.setNotificationsStatus(status: activeStatus);
                  });
                },
                child: SizedBox(
                  height: 80,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'التحكم في الاشعارات',
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          Icon(activeStatus ? Icons.notifications : Icons.notifications_off),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
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
                      height: 150,
                      width: 150,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'اذكار الصباح',
                                style: const TextStyle(fontSize: 24.0),
                              ),
                              Text(
                                DateFormat('h:mm a').format(_sabahSelectedTime),
                                style: const TextStyle(fontSize: 24.0),
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
                      height: 150,
                      width: 150,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'اذكار المساء',
                                style: const TextStyle(fontSize: 24.0),
                              ),
                              Text(
                                DateFormat('h:mm a').format(_masaaSelectedTime),
                                style: const TextStyle(fontSize: 24.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(right: 10),
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
                        height: 150,
                        width: 150,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'ورد اليوم',
                                  style: const TextStyle(fontSize: 24.0),
                                ),
                                Text(
                                  DateFormat('h:mm a').format(_werdSelectedTime),
                                  style: const TextStyle(fontSize: 24.0),
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
