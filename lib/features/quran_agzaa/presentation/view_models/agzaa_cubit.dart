import 'package:bloc/bloc.dart';
import 'package:holly_quran/features/quran_agzaa/data/models/juzh_model.dart';
import 'package:holly_quran/features/quran_agzaa/data/quran_agzaa_data.dart';
import 'package:meta/meta.dart';

part 'agzaa_state.dart';

class AgzaaCubit extends Cubit<AgzaaState> {
  AgzaaCubit() : super(AgzaaInitial());

  List<JuzhModel> agzaa = [];
  List<String> juzhSour = [];

  Future<void> fetchAgzaa() async {
    emit(AgzaaLoading());
    agzaa = quranAgzaaList;
    emit(AgzaaSuccess());
  }

  Future<void> fetchJuzhPages({required int start,required int end,}) async{
    emit(AgzaaLoading());
    juzhSour = [];
   // JuzhModel juzh = quranAgzaaList.firstWhere((element) => element.id == juzhId);
    //
    await Future.delayed(const Duration(milliseconds: 100), (){
      //for(var i=juzh.startPage;i<=juzh.endPage;i++){
      for(var i=1;i<=604;i++){
        juzhSour.add('assets/quran_data/$i.png');
      }
      emit(OpenJuzh());
    });
  }
}
