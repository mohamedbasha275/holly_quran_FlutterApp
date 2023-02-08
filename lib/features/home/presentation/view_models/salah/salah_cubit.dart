import 'package:bloc/bloc.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'salah_state.dart';

class SalahCubit extends Cubit<SalahState> {
  final HomeRepo homeRepo;

  SalahCubit(this.homeRepo) : super(SalahInitial());

  Future<void> fetchSalah() async {
    var result = await homeRepo.fetchSalah();
    if(result.isNotEmpty){
      int i = 0;
      for(SalahModel item in result){
        if(item.id != 1){
          DateTime dt1 = DateTime.now();
          DateTime dt2 = item.dateTime;
          Duration diff = dt2.difference(dt1);
          if(diff.inMinutes > 0){
            print(diff.inMinutes);
            i = (item.id - 1);
            emit(SalahSuccess(result,i));
          }
        }
      }
      emit(SalahSuccess(result,i));
    }else{
      emit(SalahLoading());
    }
    //print("i$i");
  }

  Future<void> updateLocation() async {
    AppPreferences appPreferences = getIt.get<AppPreferences>();
    Location location = Location();
    // current location
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    final _locationData = await location.getLocation();
    print(_locationData);
    await appPreferences.setCurrentLocation(lat: _locationData.latitude!, long: _locationData.longitude!);
    var result = await homeRepo.fetchSalah();
    int i = 1;
    DateTime dt1 = DateTime.now();
    for(SalahModel item in result){
      if(item.id != 1){
        DateTime dt2 = item.dateTime;
        Duration diff = dt1.difference(dt2);
        if(diff.inMinutes > 0){
          i = item.id - 1;
          break;
        }
      }
    }
    emit(SalahSuccess(result,i));
  }
}
