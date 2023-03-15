
import 'package:holly_quran/features/daily_werd/data/models/werd.dart';

abstract class WerdRepo{

  Future<List<WerdModel>> fetchWerdsData();
  Future<List<WerdModel>> addOneWerd({required String name});
  Future<List<WerdModel>> removeOnWerd({required int index});
  Future<List<WerdModel>> updateStatus({required int index});
  Future<List<WerdModel>> updateAllWerd();
}