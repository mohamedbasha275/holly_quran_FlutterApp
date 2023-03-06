import 'package:bloc/bloc.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final HomeRepo homeRepo;
  QuranCubit(this.homeRepo) : super(QuranInitial());

  List<String> quranPages = [];
  List<SurahModel> sours = [];

  String getCurrentSouraName({required int page}){
    SurahModel soura = sours.lastWhere((element) => element.pageNumber <= page);
    return soura.name;
  }
  Future<void> fetchQuran() async{
    quranPages = [];
    AppPreferences appPreferences = getIt.get<AppPreferences>();
    List<String> stop = await appPreferences.getStopReading();
    int stopSurah = int.parse(stop[0]);
    int stopPage = int.parse(stop[1]);
    String stopSurahName = stop[2];
    var result =  homeRepo.fetchQuran();
    //
    for(var i=1;i<=604;i++){
      quranPages.add('assets/quran_data/$i.png');
    }
    //
    sours = result;
    //
    emit(QuranSuccess(result,stopSurah,stopPage,stopSurahName));
  }
}
