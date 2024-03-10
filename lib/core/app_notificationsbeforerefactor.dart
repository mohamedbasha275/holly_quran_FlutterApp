// import 'dart:async';
// import 'package:adhan/adhan.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:holly_quran/core/di/service_locator.dart';
// import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
// import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// void fireAppNotifications({String? sound}) async {
//   // local
//   tz.initializeTimeZones();
//   final location = tz.getLocation('Africa/Cairo');
//   // setting
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon4');
//   var initializationSettingsIOS = const IOSInitializationSettings();
//   var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: null);
//   //
//   // tz.TZDateTime _nextInstanceOfTen() {
//   //   final tz.TZDateTime now = tz.TZDateTime.now(location);
//   //   tz.TZDateTime scheduledDate = tz.TZDateTime(location, now.year, now.month,
//   //       now.day, now.hour, now.minute, now.second + 10);
//   //   if (scheduledDate.isBefore(now)) {
//   //     scheduledDate = scheduledDate.add(const Duration(days: 1));
//   //   }
//   //   return scheduledDate;
//   // }
//   //
//   // tz.TZDateTime _nextInstanceOfFive() {
//   //   final tz.TZDateTime now = tz.TZDateTime.now(location);
//   //   tz.TZDateTime scheduledDate = tz.TZDateTime(location, now.year, now.month,
//   //       now.day, now.hour, now.minute, now.second + 5);
//   //   if (scheduledDate.isBefore(now)) {
//   //     scheduledDate = scheduledDate.add(const Duration(days: 1));
//   //   }
//   //   return scheduledDate;
//   // }
//
//   Future<void> _scheduleNotification({
//     required int id,
//     required tz.TZDateTime time,
//     required String title,
//     required String channelName,
//     required String body,
//   }) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'channel_id$id',
//       channelName,
//       'channel_description',
//       //when: DateTime.now().millisecondsSinceEpoch,
//       visibility: NotificationVisibility.public,
//       // color: AppColors.primary,
//       autoCancel: true,
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       sound: id <= 5 ? RawResourceAndroidNotificationSound('my_sound') : null,
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       time,
//       platformChannelSpecifics,
//       payload: 'test',
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//     );
//   }
//
//   tz.TZDateTime _nextInstance(
//       {required int hour, required int minute, int second = 0}) {
//     final tz.TZDateTime now = tz.TZDateTime.now(location);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//         location, now.year, now.month, now.day, hour, minute, second);
//     print("ss = $scheduledDate ");
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
//
//   tz.TZDateTime convertTime({required DateTime time}) {
//     final tz.TZDateTime now = tz.TZDateTime.now(location);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//         location, now.year, now.month, now.day, time.hour, time.minute);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
//
//   // fetch all salah times
//   // this for azan
//   List<SalahModelTime> dd = await fetchSalahTimes();
//   if (dd.isNotEmpty) {
//     for (SalahModelTime item in dd) {
//       print(item.name);
//       print(item.id);
//       // print(item.dateTime);
//       //print(convertTime(time: item.dateTime));
//       // print('-------');
//       // await _scheduleNotification(id: 2, time: _nextInstance(hour: item.dateTime.hour,
//       //     minute: item.dateTime.minute,second: item.dateTime.second),title: item.name,
//       // channelName: 'الاذان',
//       // body: 'حان الآن موعد اذان ${item.name}');
//       // print(item.dateTime.hour);
//       // print(item.dateTime.minute);
//       //print('-------');
//       // await _scheduleNotification(id: 2, time: _nextInstance(hour: item.dateTime.hour,
//       //     minute: item.dateTime.minute,second: item.dateTime.second),title: item.name,
//       //     channelName: 'الاذان',
//       //     body: 'حان الآن موعد اذان ${item.name}');
//       await flutterLocalNotificationsPlugin.cancel(item.id).then((value) {
//         _scheduleNotification(
//             id: item.id,
//             time: _nextInstance(
//               hour: item.dateTime.hour,
//               minute: item.dateTime.minute,
//               second: item.dateTime.second,
//             ),
//             title: item.name,
//             channelName: 'الاذان',
//             body: 'حان الآن موعد اذان ${item.name}');
//       });
//     }
//   }
//   var appPreferences = getIt.get<AppPreferences>();
//   List<int> times = await appPreferences.getAzkarSabah();
//   await flutterLocalNotificationsPlugin.cancel(1).then((value) {
//     _scheduleNotification(
//         id: 1,
//         title: 'sabah',
//         body: 'sbah azakar quop',
//         channelName: 'اذكار الصباح',
//         time: _nextInstance(hour: times[0], minute: times[1]));
//   });
//   //await _scheduleNotification(id: 2, time: _nextInstanceOfTen());
//   //await _scheduleNotification(id: 1, time: _nextInstanceOfFive());
//   //await _scheduleNotification(id: 3,time: _nextInstanceOfFive());
// }
//
// Future<List<SalahModelTime>> fetchSalahTimes() async {
//   List<SalahModelTime> salah = [];
//   List<String> location =
//       await getIt.get<AppPreferences>().getCurrentLocation();
//   if (location.length > 1) {
//     double lat = double.parse(location[0]);
//     double long = double.parse(location[1]);
//     final myCoordinates = Coordinates(lat, long);
//     final params = CalculationMethod.egyptian.getParameters();
//     params.madhab = Madhab.shafi;
//     final prayerTimes = PrayerTimes.today(myCoordinates, params);
//     salah.addAll([
//       SalahModelTime(
//         id: 1,
//         name: 'الفجر',
//         dateTime: prayerTimes.fajr,
//       ),
//       SalahModelTime(
//         id: 2,
//         name: 'الظهر',
//         dateTime: prayerTimes.dhuhr,
//       ),
//       SalahModelTime(
//         id: 3,
//         name: 'العصر',
//         dateTime: prayerTimes.asr,
//       ),
//       SalahModelTime(
//         id: 4,
//         name: 'المغرب',
//         dateTime: prayerTimes.maghrib,
//       ),
//       SalahModelTime(
//         id: 5,
//         name: 'العشاء',
//         dateTime: prayerTimes.isha,
//       ),
//     ]);
//   }
//   return salah;
// }
//
// //  at 12 am
// void scheduleFunction() {
//   Timer.periodic(const Duration(days: 1), (timer) async {
//     DateTime now = DateTime.now();
//     //
//     var appPreferences = getIt.get<AppPreferences>();
//     // List<int> times = await appPreferences.getAzkarSabah();
//     //
//     //DateTime scheduledTime = DateTime(now.year, now.month, now.day, times[0], times[1], 0);
//     DateTime scheduledTime = DateTime(now.year, now.month, now.day, 12, 0,
//         0); // Set the time for the function (12:00 AM)
//
//     print(scheduledTime);
//     print(now);
//     if (now.isAfter(scheduledTime)) {
//       // Call the function
//       //  myFunction();
//       print('done');
//       appPreferences.updateAllWerd();
//       timer.cancel();
//     }
//   });
// }
