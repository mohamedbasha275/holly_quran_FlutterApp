import 'package:dartz/dartz.dart';
import 'package:holly_quran/core/errors/failures.dart';
import 'package:holly_quran/features/home/data/models/book_model/book_model.dart';

abstract class HomeRepo{
  Future<Either<Failure,List<BookModel>>> fetchNewestBooks();
  Future<Either<Failure,List<BookModel>>> fetchFeaturedBooks();
  Future<Either<Failure,List<BookModel>>> fetchSimilarBooks({required String category});
}