import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void fireAppNotifications({String? sound}) async {
  // local
  tz.initializeTimeZones();
  final location = tz.getLocation('Africa/Cairo');
  //
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  // setting
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = const AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = const IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.max,
    playSound: true,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound(sound ?? 'my_sound'),
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  //
  // functions
  tz.TZDateTime _afterTenSeconds() {
    final scheduledDate =
    tz.TZDateTime.now(location).add(const Duration(seconds: 10));
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTenAMER() {
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(location, now.year, now.month, now.day, 20, now.minute,
        now.second + 5);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 19, 59);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    debugPrint(scheduledDate.toString());
    return scheduledDate;
  }

  Future<void> _scheduleNotification() async {
    print(' starts');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Title',
      'Body',
      _nextInstanceOfTenAMER(),
      platformChannelSpecifics,
      payload: 'test',
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
    print('end');
  }

  await _scheduleNotification();
}
//  at 12 am
void scheduleFunction() {
  Timer.periodic(const Duration(days: 1), (timer) {
    DateTime now = DateTime.now();
    DateTime scheduledTime = DateTime(now.year, now.month, now.day, 0, 0, 0); // Set the time for the function (12:00 AM)

    if (now.hour == scheduledTime.hour && now.minute == scheduledTime.minute) {
      // Call the function
    //  myFunction();
    }
  });
}

// organized sound


// Future<void> _showNotification({required id}) async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     'channel_id$id', 'channel_name', 'channel_description',
//     importance: Importance.max, priority: Priority.high,playSound: true,
//     sound: id == 2 ? RawResourceAndroidNotificationSound('my_sound') : null,
//   );
//   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     id, 'العنوان', 'المحتوى', platformChannelSpecifics,
//     payload: 'البيانات الإضافية',
//   );
// }