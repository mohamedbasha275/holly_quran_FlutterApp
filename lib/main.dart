import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/theme_manager.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:holly_quran/features/home/presentation/view_models/quran/quran_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/sadaqat/sadaqat_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/salah/salah_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configure injecction
  setupServiceLocator();
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
