import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/features/home/data/models/book_model/book_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:holly_quran/features/home/presentation/view_models/similar_books/similar_books_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/book_details_view.dart';
import 'package:holly_quran/features/home/presentation/views/home_view.dart';

abstract class AppRouters {
  static const String kSplashView = '/';
  static const String kHomeView = '/homeView';
  static const String kBookDetailsView = '/bookDetailsView';
  static const String kSearchView = '/searchView';
  // GoRouter configuration
  static final router = GoRouter(
    routes: [
      // GoRoute(
      //   path: kSplashView,
      //   builder: (context, state) => const SplashView(),
      // ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) => BlocProvider(
          create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
          child: BookDetailsView(book: state.extra as BookModel), // to send model when navigate
        ),
      ),
      // GoRoute(
      //   path: kSearchView,
      //   builder: (context, state) => const SearchView(),
      // ),
    ],
  );
}
