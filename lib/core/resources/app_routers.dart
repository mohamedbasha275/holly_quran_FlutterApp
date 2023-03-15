import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/features/azkar/presentation/views/azkar_masaa_view.dart';
import 'package:holly_quran/features/azkar/presentation/views/azkar_sabah_view.dart';
import 'package:holly_quran/features/contact_us/presentation/contact_us_view.dart';
import 'package:holly_quran/features/contact_us/presentation/widgets/contact_us_view_body.dart';
import 'package:holly_quran/features/daily_werd/data/repos/werd_repo.dart';
import 'package:holly_quran/features/daily_werd/data/repos/werd_repo_impl.dart';
import 'package:holly_quran/features/daily_werd/presentation/view_models/werd_cubit.dart';
import 'package:holly_quran/features/daily_werd/presentation/views/werd_view.dart';
import 'package:holly_quran/features/day_wheel/presentation/views/day_wheel_view.dart';
import 'package:holly_quran/features/hadith/presentation/views/hadith_view.dart';
import 'package:holly_quran/features/hesn_muslim/presentation/view_models/hesn_cubit.dart';
import 'package:holly_quran/features/hesn_muslim/presentation/views/hesn_muslim_view.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/bottom_navBar/bottom_nav_bar_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/quran/quran_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/home_view.dart';
import 'package:holly_quran/features/home/presentation/views/surah_view.dart';
import 'package:holly_quran/features/home/presentation/views/sadaqa_surah_view.dart';
import 'package:holly_quran/features/ihdaa/ihdaa_view.dart';
import 'package:holly_quran/features/quran_agzaa/presentation/view_models/agzaa_cubit.dart';
import 'package:holly_quran/features/quran_agzaa/presentation/views/juzh_view.dart';
import 'package:holly_quran/features/quran_agzaa/presentation/views/quran_agzaa_view.dart';

class Routes {
  // static const String splashRoute = "/";
  static const String homeRoute = "/";
  static const String searchRoute = "/search";
  static const String azkarSabahRoute = "/azkarSabah";
  static const String azkarMasaaRoute = "/azkarMasaa";
  static const String hadithRoute = "/hadith";
  static const String hesnMuslimRoute = "/hesnMuslim";
  static const String surahDetailsRoute = "/surahDetails";
  static const String sadaqaSurahViewRoute = "/sadaqaSurahView";
  static const String dayWheelRoute = "/dayWheelView";
  static const String ihdaaRoute = "/ihdaaView";
  static const String quranAgzaa = "/quranAgzaa";
  static const String juzhDetailsRoute = "/juzhDetailsRoute";
  static const String werdViewRoute = "/werdViewRoute";
  static const String contactViewRoute = "/contactViewRoute";
}

abstract class AppRouters {
  // GoRouter configuration
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.homeRoute,
        name: Routes.homeRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => BottomNavBarCubit(),
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: Routes.azkarMasaaRoute,
        builder: (context, state) => const AzkarMasaaView(),
      ),
      GoRoute(
        path: Routes.azkarSabahRoute,
        builder: (context, state) => const AzkarSabahView(),
      ),
      GoRoute(
        path: Routes.hesnMuslimRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => HesnCubit()..fetchHesn(),
          child: const HesnMuslimView(),
        ),
      ),
      GoRoute(
        path: Routes.hadithRoute,
        builder: (context, state) => const HadithView(),
      ),
      GoRoute(
        path: Routes.quranAgzaa,
        builder: (context, state) => BlocProvider(
          create: (context) => AgzaaCubit()..fetchAgzaa(),
          child: const QuranAgzaaView(),
        ),
      ),
      GoRoute(
        path: "${Routes.surahDetailsRoute}:id1/:id2",
        name: Routes.surahDetailsRoute,
        builder: (context, state) {
          String surahId = state.params['id1'] as String;
          SurahModel model = BlocProvider.of<QuranCubit>(context)
              .sours[int.parse(surahId) - 1];
          return SurahView(
            //surah:  state.params['id1'] as SurahModel,
            surah: model,
            stopPage: state.params['id2'] as String,
          );
        },
        //builder: (context, state) => SurahView(),
      ),
      GoRoute(
        path: "${Routes.juzhDetailsRoute}:id1/:id2",
        name: Routes.juzhDetailsRoute,
        builder: (context, state) => BlocProvider(
          create: (context) {
            var startPage  = state.params['id1'] as String;
            var endPage  = state.params['id2'] as String;
            return AgzaaCubit()
              ..fetchJuzhPages(start: int.parse(startPage),
                  end: int.parse(endPage));
          },
          child: JuzhView(
            startPage: state.params['id1'] as String,
            //endPage: state.params['id2'] as String,
          ),
        ),
      ),
      GoRoute(
        path: Routes.dayWheelRoute,
        builder: (context, state) => const DayWheelView(),
      ),
      GoRoute(
        path: Routes.contactViewRoute,
        builder: (context, state) => const ContactUsView(),
      ),
      GoRoute(
        path: Routes.werdViewRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => WerdCubit(getIt.get<WerdRepoImpl>())..fetchWerds(),
          child: const WerdView(),
        ),
      ),
      GoRoute(
        path: Routes.ihdaaRoute,
        builder: (context, state) => const IhdaaView(),
      ),
      GoRoute(
        path: "${Routes.sadaqaSurahViewRoute}:id1/:id2",
        name: Routes.sadaqaSurahViewRoute,
        builder: (context, state) => SadaqaSurahView(
            name: state.params['id1'] as String,
            pageNumber: state.params['id2'] as String),
      ),
      // GoRoute(
      //   path: Routes.bookDetailsRoute,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
      //     child: BookDetailsView(
      //         book: state.extra as BookModel), // to send model when navigate
      //   ),
      // ),
    ],
  );
}
