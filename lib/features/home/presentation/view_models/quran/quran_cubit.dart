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

  Future<void> fetchQuran() async{
    AppPreferences appPreferences = getIt.get<AppPreferences>();
    List<String> stop = await appPreferences.getStopReading();
    int stopSurah = int.parse(stop[0]);
    int stopAya = int.parse(stop[1]);
    var result =  homeRepo.fetchQuran();
    emit(QuranSuccess(result,stopSurah,stopAya));
  }
}
