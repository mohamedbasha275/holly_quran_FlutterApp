import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:holly_quran/features/home/presentation/view_models/featured_books/featured_books_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/newest_books/newest_books_cubit.dart';

void main() {
  setupServiceLocator();
  runApp(const BookLyApp());
}

class BookLyApp extends StatelessWidget {
  const BookLyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.deepPurple,
    // ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> FeaturedBooksCubit(getIt.get<HomeRepoImpl>())..fetchFeaturedBooks()),
        BlocProvider(create: (context)=> NewestBooksCubit(getIt.get<HomeRepoImpl>())..fetchNewestBooks()),
      ],
      child: MaterialApp.router(
        title: 'mainTitle',
        routerConfig: AppRouters.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          primaryColor: const Color.fromRGBO(82, 72, 195, 1)
        ),
      ),
    );
  }
}