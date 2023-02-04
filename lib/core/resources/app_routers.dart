import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/features/azkar_sabah/presentation/views/azkar_sabah_view.dart';
import 'package:holly_quran/features/hadith/presentation/views/hadith_view.dart';
import 'package:holly_quran/features/home/data/models/book_model/book_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:holly_quran/features/home/presentation/view_models/botoom_navBae/bottom_nav_bar_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/similar_books/similar_books_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/book_details_view.dart';
import 'package:holly_quran/features/home/presentation/views/home_view.dart';

class Routes {
  // static const String splashRoute = "/";
  static const String homeRoute = "/";
  static const String bookDetailsRoute = "/bookDetails";
  static const String searchRoute = "/search";
  static const String azkarSabahRoute = "/azkarSabah";
  static const String azkarMasaaRoute = "/azkarMasaa";
  static const String hadithRoute = "/hadith";
  static const String hesnMuslimRoute = "/hesnMuslim";
}

abstract class AppRouters {
  // GoRouter configuration
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.homeRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => BottomNavBarCubit(),
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: Routes.azkarMasaaRoute,
        builder: (context, state) => const HadithView(),
      ),
      GoRoute(
        path: Routes.azkarSabahRoute,
        builder: (context, state) => const AzkarSabahView(),
      ),
      GoRoute(
        path: Routes.hesnMuslimRoute,
        builder: (context, state) => const HadithView(),
      ),
      GoRoute(
        path: Routes.hadithRoute,
        builder: (context, state) => const HadithView(),
      ),
      GoRoute(
        path: Routes.bookDetailsRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
          child: BookDetailsView(
              book: state.extra as BookModel), // to send model when navigate
        ),
      ),
    ],
  );
}
