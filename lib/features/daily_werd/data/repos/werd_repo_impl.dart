import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/daily_werd/data/models/werd.dart';
import 'package:holly_quran/features/daily_werd/data/repos/werd_repo.dart';

class WerdRepoImpl implements WerdRepo {
  final AppPreferences appPreferences;
  WerdRepoImpl(this.appPreferences);
  @override
  Future<List<WerdModel>> fetchWerdsData() async{
    List<WerdModel> werds = await appPreferences.getAllWerd();
    return werds;
  }
  @override
  Future<List<WerdModel>> addOneWerd({required String name}) async {
    await appPreferences.addOnWerd(name: name);
    List<WerdModel> werds = await appPreferences.getAllWerd();
    return werds;
  }
  @override
  Future<List<WerdModel>> removeOnWerd({required int index}) async {
    await appPreferences.removeOnWerd(index: index);
    List<WerdModel> werds = await appPreferences.getAllWerd();
    return werds;
  }
  @override
  Future<List<WerdModel>> updateStatus({required int index}) async {
    await appPreferences.updateWerd(index: index);
    List<WerdModel> werds = await appPreferences.getAllWerd();
    return werds;
  }
  @override
  Future<List<WerdModel>> updateAllWerd() async {
    await appPreferences.updateAllWerd();
    List<WerdModel> werds = await appPreferences.getAllWerd();
    return werds;
  }
}
