import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:holly_quran/core/errors/failures.dart';
import 'package:holly_quran/core/dio/api_service.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/features/home/data/models/book_model/book_model.dart';
import 'package:holly_quran/features/home/data/models/quran/aya_model.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo.dart';
import 'package:quran/quran.dart' as quran;

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<BookModel>>> fetchNewestBooks() async {
    try {
      var data = await apiService.get(url: 'volumes?Filtering=free-ebooks&q=subject:agriculture');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      var data = await apiService.get(
          url: 'volumes?Filtering=free-ebooks&q=subject:Programming');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
      {required String category}) async {
    try {
      var data = await apiService.get(
          url:
              'volumes?Filtering=free-ebooks&Sorting=relevance &q=subject:$category');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  // fetchQuran
  @override
  List<SurahModel> fetchQuran() {
    List<SurahModel> sours = [];
    for (int i = 1; i <= quran.totalSurahCount; i++) {
      sours.add(
        SurahModel(
          id: i,
          name: quran.getSurahNameArabic(i),
          type: arPlaceName(quran.getPlaceOfRevelation(i)),
          ayatNumber: quran.getVerseCount(i),
        ),
      );
    }
    return sours;
  }
}
