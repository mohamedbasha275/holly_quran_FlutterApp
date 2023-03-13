import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void fireAppNotifications({String? sound}) async {
  // local
  tz.initializeTimeZones();
  final location = tz.getLocation('Africa/Cairo');
  // setting
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = const IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: null);
  //
  tz.TZDateTime _nextInstanceOfTen() {
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(location, now.year, now.month, now.day, now.hour, now.minute,
        now.second + 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
  tz.TZDateTime _nextInstanceOfFive() {
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(location, now.year, now.month, now.day, now.hour, now.minute,
        now.second + 5);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }


  Future<void> _scheduleNotification({required id,required time}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id$id', 'channel_name', 'channel_description',
      when: DateTime.now().millisecondsSinceEpoch,
      importance: Importance.max, priority: Priority.high,playSound: true,
      sound: id == 2 ? RawResourceAndroidNotificationSound('my_sound') : null,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'اذكار الصباح',
      'الحمد لله الذي أصبحنا',
      time,
      platformChannelSpecifics,
      payload: 'test',
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  await _scheduleNotification(id: 2,time: _nextInstanceOfTen());
  await _scheduleNotification(id: 1,time: _nextInstanceOfFive());
  //await _scheduleNotification(id: 3,time: _nextInstanceOfFive());
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