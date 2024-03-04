import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';
import 'package:holly_quran/features/home/data/models/tasbih/tasbih_model.dart';

abstract class HomeRepo{
  // Future<Either<Failure,List<BookModel>>> fetchNewestBooks();
  // Future<Either<Failure,List<BookModel>>> fetchFeaturedBooks();
  // Future<Either<Failure,List<BookModel>>> fetchSimilarBooks({required String category});
  List<SurahModel> fetchQuran();
  Future<List<String>> fetchSadaqat();
  Future<List<String>> addOneSadaqa({required String name});
  Future<List<String>> removeOneSadaqa({required int index});
  Future<List<SalahModel>> fetchSalah();
  //
  Future<List<TasbihModel>> fetchTasbih();
  Future<void> addOneTasbih({required String name,required int counter});
  Future<void> removeOneTasbih({required int tasbihId});
  Future<void> updateTasbih({required int id,required String name,required int counter});
}