import 'package:bloc/bloc.dart';
import 'package:holly_quran/features/hesn_muslim/data/hesn_muslim_data.dart';
import 'package:holly_quran/features/hesn_muslim/data/models/hesn_model.dart';
import 'package:meta/meta.dart';

part 'hesn_state.dart';

class HesnCubit extends Cubit<HesnState> {
  HesnCubit() : super(HesnInitial());

  Future<void> fetchHesn() async{
    emit(HesnLoading());
    await Future.delayed(const Duration(milliseconds: 200), (){
      emit(HesnSuccess(hesnMuslimList));
    });
  }
}
