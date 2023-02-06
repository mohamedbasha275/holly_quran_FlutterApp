import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';

abstract class HomeRepo{
  // Future<Either<Failure,List<BookModel>>> fetchNewestBooks();
  // Future<Either<Failure,List<BookModel>>> fetchFeaturedBooks();
  // Future<Either<Failure,List<BookModel>>> fetchSimilarBooks({required String category});
  List<SurahModel> fetchQuran();
}