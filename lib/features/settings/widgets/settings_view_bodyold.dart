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
  late DateTime _sabahSelectedTime = DateTime.now();
  late DateTime _masaaSelectedTime = DateTime.now();

  // get time from shared
  Future<void> _loadSelectedTime() async {
    final now = DateTime.now();
    List<int> sabahTimes = await appPreferences.getAzkarSabah();
    setState(() {
      _sabahSelectedTime =
          DateTime(now.year, now.month, now.day, sabahTimes[0], sabahTimes[1]);
    });
  }

  @override
  void initState() {
    super.initState();
    sabahPicked = TimeOfDay.fromDateTime(_sabahSelectedTime);
    masaaPicked = TimeOfDay.fromDateTime(_masaaSelectedTime);
    _loadSelectedTime();
  }

  void _showSettingsViewBody(BuildContext context,
      {required TimeOfDay? picked,
      required DateTime selectedTime,
      required void Function(DateTime) onTimeSelected}) async {
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
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () => _showSettingsViewBody(context,
                picked: sabahPicked,
                selectedTime: _sabahSelectedTime, onTimeSelected: (newTime) {
              setState(() {
                _sabahSelectedTime = newTime;
                appPreferences.setAzkarSabah(hour: newTime.hour, minute: newTime.minute);
                sabahPicked = TimeOfDay.fromDateTime(newTime);
              });
            }),
            child: Center(
              child: Text(
                _sabahSelectedTime != null
                    ? DateFormat('h:mm a').format(_sabahSelectedTime)
                    : '',
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _showSettingsViewBody(context,
                picked: masaaPicked,
                selectedTime: _masaaSelectedTime, onTimeSelected: (newTime) {
              setState(() {
                _masaaSelectedTime = newTime;
                masaaPicked = TimeOfDay.fromDateTime(newTime);
              });
            }),
            child: Center(
              child: Text(
                _masaaSelectedTime != null
                    ? DateFormat('h:mm a').format(_masaaSelectedTime)
                    : '',
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
