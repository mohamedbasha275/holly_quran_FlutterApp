import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void scheduleNotification({
  required int id,
  required String title,
  required String body,
  required String channelName,
  required tz.TZDateTime scheduledTime,
}) async {
  // Initialize the timezone and local notifications plugin
  tz.initializeTimeZones();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon7');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Configure notification details
  var androidDetails = AndroidNotificationDetails(
    'channel_id$id',
    channelName,
    visibility: NotificationVisibility.public,
    color: AppColors.primary,
    autoCancel: true,
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );
  var generalNotificationDetails = NotificationDetails(android: androidDetails);

  // Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    scheduledTime,
    generalNotificationDetails,
    payload: 'test',
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}


void showInstantNotification({
  required int id,
  required String title,
  required String body,
  required String channelName,
  required tz.TZDateTime time,
}) async {
  // local
  tz.initializeTimeZones();
  final location = tz.getLocation('Africa/Cairo');
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Initialization settings for Android and iOS
  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon7');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);



  var androidDetails = AndroidNotificationDetails(
    'channel_id$id',
    channelName,
    //'channel_description',
    visibility: NotificationVisibility.public,
    color: AppColors.primary,
    autoCancel: true,
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );
  var generalNotificationDetails = NotificationDetails(
    android: androidDetails,
  );

  // flutterLocalNotificationsPlugin.show(
  //   id,
  //   title,
  //   body,
  //   generalNotificationDetails,
  //   payload: 'Item x',
  // );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    time,
    generalNotificationDetails,
    payload: 'test',
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
        .absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}