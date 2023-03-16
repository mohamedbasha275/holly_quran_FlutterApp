import 'package:flutter/material.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:intl/intl.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  _SettingsViewBodyState createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  late DateTime _selectedTime = DateTime.now();
  AppPreferences appPreferences = getIt.get<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _loadSelectedTime();
  }

  Future<void> _loadSelectedTime() async {
    final now = DateTime.now();
    List<int> times = await appPreferences.getAzkarSabah();
    setState(() {
      _selectedTime =
          DateTime(now.year, now.month, now.day, times[0], times[1]);
    });
  }

  void _showSettingsViewBody(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );

    if (picked != null) {
      print(picked.hour);
      print(picked.minute);
      appPreferences.setAzkarSabah(hour: picked.hour, minute: picked.minute);
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => _showSettingsViewBody(context),
        child: Center(
          child: Text(
              _selectedTime != null ? DateFormat('h:mm a').format(_selectedTime) : '',
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
