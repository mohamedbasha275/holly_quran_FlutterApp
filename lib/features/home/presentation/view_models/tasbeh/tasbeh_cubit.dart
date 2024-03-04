import 'package:bloc/bloc.dart';
import 'package:holly_quran/features/home/data/models/tasbih/tasbih_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'tasbeh_state.dart';

class TasbehCubit extends Cubit<TasbehState> {
  final HomeRepo homeRepo;

  TasbehCubit(this.homeRepo) : super(TasbehInitial());

  Future<void> fetchTasbih() async {
    var result = await homeRepo.fetchTasbih();
    if (result.isNotEmpty) {
      emit(TasbehSuccess(result));
    } else {
      emit(TasbehLoading());
    }
  }

  Future<void> addOneTasbih(
      {required String name, required int counter}) async {
    var result = await homeRepo.addOneTasbih(name: name, counter: counter);
    fetchTasbih();
  }

  Future<void> updateTasbih(
      {required int id, required String name, required int counter}) async {
    var result =
        await homeRepo.updateTasbih(id: id, name: name, counter: counter);
    fetchTasbih();
  }

  Future<void> removeOneTasbih({required int tasbihId}) async {
    var result = await homeRepo.removeOneTasbih(tasbihId: tasbihId);
    fetchTasbih();
  }
}
