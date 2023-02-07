import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:holly_quran/core/dio/api_service.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupServiceLocator() async{
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  //getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiService>()));
  //getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl(getIt.get<ApiService>()));
  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // app prefs instance
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt.get<SharedPreferences>()));
  getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl(getIt.get<AppPreferences>()));
  //getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<AppPreferences>()));
}

// initStoreDetailsModule() {
//   if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
//     instance.registerFactory<StoreDetailsUseCase>(
//             () => StoreDetailsUseCase(instance()));
//     instance.registerFactory<StoreDetailsViewModel>(
//             () => StoreDetailsViewModel(instance()));
//   }
// }