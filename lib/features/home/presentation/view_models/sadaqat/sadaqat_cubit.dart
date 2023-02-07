import 'package:bloc/bloc.dart';
import 'package:holly_quran/features/home/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'sadaqat_state.dart';

class SadaqatCubit extends Cubit<SadaqatState> {
  final HomeRepo homeRepo;
  SadaqatCubit(this.homeRepo) : super(SadaqatInitial());

  Future<void> fetchSadaqat() async{
    var result = await homeRepo.fetchSadaqat();
    emit(SadaqatSuccess(result));
  }
  Future<void> addOneSadaqa({required String name}) async{
    var result = await homeRepo.addOneSadaqa(name: name);
    emit(SadaqatSuccess(result));
  }
  Future<void> removeOneSadaqa({required int index}) async{
    var result = await homeRepo.removeOneSadaqa(index: index);
    emit(SadaqatSuccess(result));
  }
}
