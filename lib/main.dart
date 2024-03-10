import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:holly_quran/core/app_notifications.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/theme_manager.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:holly_quran/features/home/presentation/view_models/quran/quran_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/sadaqat/sadaqat_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/salah/salah_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/tasbeh/tasbeh_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //

  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Configure injecction
  setupServiceLocator();
  // notifications
  // AppPreferences appPreferences = getIt.get<AppPreferences>();
  // print(appPreferences.getNotificationsStatus());
  fireAppNotifications();
  //fireAppNotifications(sound: 'my_sound');
  // io
  scheduleFunction();
  // permissions
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  //
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuranCubit(getIt.get<HomeRepoImpl>())..fetchQuran()),
        BlocProvider(create: (context) => SadaqatCubit(getIt.get<HomeRepoImpl>())..fetchSadaqat()),
        BlocProvider(create: (context) => TasbehCubit(getIt.get<HomeRepoImpl>())..fetchTasbih()),
        BlocProvider(create: (context) => SalahCubit(getIt.get<HomeRepoImpl>())..fetchSalah()),
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
