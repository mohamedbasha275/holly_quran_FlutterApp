import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;



void fireAppNotifications({String? sound}) async {
  // local
  tz.initializeTimeZones();
  final location = tz.getLocation('Africa/Cairo');
  // setting
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon7');
  //var initializationSettingsIOS = const IOSInitializationSettings();
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //
  //
  //
  Future<void> _scheduleNotification({
    required int id,
    required tz.TZDateTime time,
    required String title,
    required String channelName,
    required String body,
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id$id',
      channelName,
      //'channel_description',
      visibility: NotificationVisibility.public,
      color: AppColors.primary,
      autoCancel: true,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
     // sound: id <= 5 ? const RawResourceAndroidNotificationSound('my_sound') : null,
    );
    //var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      time,
      platformChannelSpecifics,
      payload: 'test',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  tz.TZDateTime _nextFriday({required int hour, required int minute, int second = 0}) {
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    // Calculate the next Friday
    tz.TZDateTime nextFriday = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
      second,
    );
    while (nextFriday.weekday != DateTime.friday) {
      nextFriday = nextFriday.add(const Duration(days: 1));
    }
    if (nextFriday.isBefore(now)) {
      nextFriday = nextFriday.add(const Duration(days: 7));
    }
    return nextFriday;
  }

  tz.TZDateTime _nextInstance(
      {required int hour, required int minute, int second = 0}) {
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        location, now.year, now.month, now.day, hour, minute, second);
    //print("ss = $scheduledDate ");
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
  // fetch all salah times
  // this for azan
  // List<SalahModelTime> dd = await fetchSalahTimes();
  // if (dd.isNotEmpty) {
  //   for (SalahModelTime item in dd) {
  //     await flutterLocalNotificationsPlugin.cancel(item.id).then((value) {
  //       _scheduleNotification(
  //           id: item.id,
  //           time: _nextInstance(
  //             hour: item.dateTime.hour,
  //             minute: item.dateTime.minute,
  //             second: item.dateTime.second,
  //           ),
  //           title: item.name,
  //           channelName: 'الاذان',
  //           body: 'حان الآن موعد اذان ${item.name}');
  //     });
  //   }
  // }
  // azkar
  var appPreferences = getIt.get<AppPreferences>();
  List<int> sabahTimes = await appPreferences.getAzkarSabah();
  List<int> masaaTimes = await appPreferences.getAzkarMasaa();
  List<int> werdTimes = await appPreferences.getAzkarWerd();
  bool status = await appPreferences.getNotificationsStatus();
  print(status);
  if(status){
    await flutterLocalNotificationsPlugin.cancel(6).then((value) {
      _scheduleNotification(
          id: 6,
          title: 'أذكار الصباح',
          body: 'الحمد لله الذي أصبحنا',
          channelName: 'أذكار الصباح',
          time: _nextInstance(hour: sabahTimes[0], minute: sabahTimes[1]));
    });
    await flutterLocalNotificationsPlugin.cancel(7).then((value) {
      _scheduleNotification(
          id: 7,
          title: 'أذكار المساء',
          body: 'الحمد لله الذي أمسينا',
          channelName: 'أذكار المساء',
          time: _nextInstance(hour: masaaTimes[0], minute: masaaTimes[1]));
    });
    await flutterLocalNotificationsPlugin.cancel(8).then((value) {
      _scheduleNotification(
          id: 8,
          title: 'ورد اليوم',
          body: 'أحرص علي وردك اليومي',
          channelName: 'ورد اليوم',
          time: _nextInstance(hour: werdTimes[0], minute: werdTimes[1]));
    });
    await flutterLocalNotificationsPlugin.cancel(9).then((value) {
      _scheduleNotification(
          id: 9,
          title: 'سورة الكهف',
          body: 'لا يفوتك ثواب سورة الكهف',
          channelName: 'سورة الكهف',
          time:  _nextFriday(hour: 15, minute: 0),
      );
    });
  }
}

Future<List<SalahModelTime>> fetchSalahTimes() async {
  List<SalahModelTime> salah = [];
  List<String> location = await getIt.get<AppPreferences>().getCurrentLocation();
  if (location.length > 1) {
    double lat = double.parse(location[0]);
    double long = double.parse(location[1]);
    final myCoordinates = Coordinates(lat, long);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    salah.addAll([
      SalahModelTime(
        id: 1,
        name: 'الفجر',
        dateTime: prayerTimes.fajr,
      ),
      SalahModelTime(
        id: 2,
        name: 'الظهر',
        dateTime: prayerTimes.dhuhr,
      ),
      SalahModelTime(
        id: 3,
        name: 'العصر',
        dateTime: prayerTimes.asr,
      ),
      SalahModelTime(
        id: 4,
        name: 'المغرب',
        dateTime: prayerTimes.maghrib,
      ),
      SalahModelTime(
        id: 5,
        name: 'العشاء',
        dateTime: prayerTimes.isha,
      ),
    ]);
  }
  return salah;
}

//  at 12 am
void scheduleFunction() {
  DateTime now = DateTime.now();
  DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
  Duration initialDelay = nextMidnight.difference(now);
  Timer(initialDelay, () {
    var appPreferences = getIt.get<AppPreferences>();
    appPreferences.updateAllWerd();

    // Now that we've done the first update, set a periodic timer for every 24 hours.
    Timer.periodic(const Duration(days: 1), (timer) async {
      appPreferences.updateAllWerd();
    });
  });
}
