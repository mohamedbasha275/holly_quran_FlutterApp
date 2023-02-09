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
      int nextSalahIndex = getNextSalahIndex(result);
      emit(SalahSuccess(result,nextSalahIndex));
    }else{
      emit(SalahLoading());
    }
    //print("i$i");
  }

  Future<void> updateLocation() async {
    await getCurrentLocation();
    var result = await homeRepo.fetchSalah();
    int nextSalahIndex = getNextSalahIndex(result);
    emit(SalahSuccess(result,nextSalahIndex));
  }
}
// getNextSalahIndex
int getNextSalahIndex(List<SalahModel> list){
  int nextIndex = 0;
  List<int> allNext = [];
  for(SalahModel item in list){
    if(item.id != 2){
      DateTime dt1 = DateTime.now();
      DateTime dt2 = item.dateTime;
      Duration diff = dt2.difference(dt1);
      if(diff.inMinutes > 0){
        allNext.add(item.id - 1);
      }
    }
  }
  nextIndex = allNext.isNotEmpty ? allNext[0] : 0;
  return nextIndex;
}
// get Current Location
Future<void> getCurrentLocation() async{
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
}