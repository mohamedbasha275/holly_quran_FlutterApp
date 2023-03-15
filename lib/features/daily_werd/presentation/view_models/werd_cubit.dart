import 'package:bloc/bloc.dart';
import 'package:holly_quran/features/daily_werd/data/models/werd.dart';
import 'package:holly_quran/features/daily_werd/data/repos/werd_repo.dart';
import 'package:meta/meta.dart';
part 'werd_state.dart';

class WerdCubit extends Cubit<WerdState> {
  final WerdRepo werdRepo;
  WerdCubit(this.werdRepo) : super(WerdInitial());

  Future<void> fetchWerds() async{
    List<WerdModel> werds = await werdRepo.fetchWerdsData();
    if(werds.isNotEmpty){
      emit(WerdSuccess(werds));
    }else{
      emit(WerdLoading());
    }
  }
  Future<void> addOneWerd({required String name}) async{
    var result = await werdRepo.addOneWerd(name: name);
    emit(WerdSuccess(result));
  }
  Future<void> removeOneWerd({required int index}) async{
    List<WerdModel> werds = await werdRepo.removeOnWerd(index: index);
    if(werds.isNotEmpty){
      emit(WerdSuccess(werds));
    }else{
      emit(WerdLoading());
    }
  }
  Future<void> updateWerd({required int index}) async{
    List<WerdModel> werds = await werdRepo.updateStatus(index: index);
    if(werds.isNotEmpty){
      emit(WerdSuccess(werds));
    }else{
      emit(WerdLoading());
    }
  }
  Future<void> updateAllWerd() async{
    List<WerdModel> werds = await werdRepo.updateAllWerd();
    if(werds.isNotEmpty){
      emit(WerdSuccess(werds));
    }else{
      emit(WerdLoading());
    }
  }
}
