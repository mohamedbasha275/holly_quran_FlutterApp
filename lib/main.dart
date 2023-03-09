import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/theme_manager.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:holly_quran/features/home/presentation/view_models/quran/quran_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/sadaqat/sadaqat_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/salah/salah_cubit.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configure injecction
  setupServiceLocator();
  // notifications
  tz.initializeTimeZones();
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = const IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);


  //await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  Future<void> _scheduleNotification() async {
    final location = tz.getLocation('Africa/Cairo');
    final scheduledDate =
        tz.TZDateTime.now(location).add(const Duration(seconds: 10));
    print(scheduledDate);

    tz.TZDateTime _nextInstanceOfTenAM() {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate =
          tz.TZDateTime(tz.local, now.year, now.month, now.day, 20, 47);
      if (scheduledDate.isBefore(now)) {
        print('ooo');
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      return scheduledDate;
    }

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    //  sound: RawResourceAndroidNotificationSound('my_sound'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   0,
    //   'Title',
    //   'Body',
    //   _nextInstanceOfTenAM(),
    //   // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    //   platformChannelSpecifics,
    //   payload: 'test',
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   androidAllowWhileIdle: true,
    // );
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Tifffffftle',
      'EEEE',
      Time(20, 49, 0),
      platformChannelSpecifics,
      payload: 'Default_Sound',
      // androidAllowWhileIdle: true,
      // uiLocalNotificationDateInterpretation:
      // UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  await _scheduleNotification();
  //
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarAndNavigationBarColors();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                QuranCubit(getIt.get<HomeRepoImpl>())..fetchQuran()),
        BlocProvider(
            create: (context) =>
                SadaqatCubit(getIt.get<HomeRepoImpl>())..fetchSadaqat()),
        BlocProvider(
            create: (context) =>
                SalahCubit(getIt.get<HomeRepoImpl>())..fetchSalah()),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        routerConfig: AppRouters.router,
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
      ),
    );
  }
}
