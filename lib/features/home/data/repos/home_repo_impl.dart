import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo.dart';
import 'package:intl/intl.dart';
import 'package:quran/quran.dart' as quran;

class HomeRepoImpl implements HomeRepo {
  //final ApiService apiService;
  //final AppPreferences appPreferences;
  final AppPreferences appPreferences;

  //HomeRepoImpl(this.apiService,this.appPreferences);
  HomeRepoImpl(this.appPreferences);

  // @override
  // Future<Either<Failure, List<BookModel>>> fetchNewestBooks() async {
  //   try {
  //     var data = await apiService.get(url: 'volumes?Filtering=free-ebooks&q=subject:agriculture');
  //     List<BookModel> books = [];
  //     for (var item in data['items']) {
  //       books.add(BookModel.fromJson(item));
  //     }
  //     return right(books);
  //   } catch (e) {
  //     if (e is DioError) {
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     return left(ServerFailure(e.toString()));
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
  //   try {
  //     var data = await apiService.get(
  //         url: 'volumes?Filtering=free-ebooks&q=subject:Programming');
  //     List<BookModel> books = [];
  //     for (var item in data['items']) {
  //       books.add(BookModel.fromJson(item));
  //     }
  //     return right(books);
  //   } catch (e) {
  //     if (e is DioError) {
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     return left(ServerFailure(e.toString()));
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
  //     {required String category}) async {
  //   try {
  //     var data = await apiService.get(
  //         url:
  //             'volumes?Filtering=free-ebooks&Sorting=relevance &q=subject:$category');
  //     List<BookModel> books = [];
  //     for (var item in data['items']) {
  //       books.add(BookModel.fromJson(item));
  //     }
  //     return right(books);
  //   } catch (e) {
  //     if (e is DioError) {
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  // fetchQuran
  @override
  List<SurahModel> fetchQuran() {
    List<SurahModel> sours = [];
    for (int i = 1; i <= quran.totalSurahCount; i++) {
      sours.add(
        SurahModel(
          id: i,
          name: quran.getSurahNameArabic(i),
          type: arPlaceName(quran.getPlaceOfRevelation(i)),
          ayatNumber: quran.getVerseCount(i),
        ),
      );
    }
    return sours;
  }

  // fetchSadaqat
  @override
  Future<List<String>> fetchSadaqat() async {
    List<String> sadaqat = await appPreferences.getAllSadaqat();
    return sadaqat;
  }

  // addOneSadaqa
  @override
  Future<List<String>> addOneSadaqa({required String name}) async {
    await appPreferences.addOnSadaqa(name: name);
    List<String> sadaqat = await appPreferences.getAllSadaqat();
    return sadaqat;
  }

  // removeOneSadaqa
  @override
  Future<List<String>> removeOneSadaqa({required int index}) async {
    await appPreferences.removeOneSadaqa(index: index);
    List<String> sadaqat = await appPreferences.getAllSadaqat();
    return sadaqat;
  }

  // fetchSalah
  @override
  Future<List<SalahModel>> fetchSalah() async {
    List<SalahModel> salah = [];
    List<String> location = await appPreferences.getCurrentLocation();
    if(location.length > 1){
      double lat = double.parse(location[0]);
      double long = double.parse(location[1]);
      final myCoordinates = Coordinates(lat, long);
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(myCoordinates, params);
      salah.addAll([
        SalahModel(
          id: 1,
          name: 'الفجر',
          time: DateFormat.jm().format(prayerTimes.fajr),
          dateTime: prayerTimes.fajr,
          icon: Icons.dark_mode_outlined,
        ),
        SalahModel(
          id: 2,
          name: 'الشروق',
          time: DateFormat.jm().format(prayerTimes.sunrise),
          dateTime: prayerTimes.sunrise,
          icon: Icons.sunny,
        ),
        SalahModel(
          id: 3,
          name: 'الظهر',
          time: DateFormat.jm().format(prayerTimes.dhuhr),
          dateTime: prayerTimes.dhuhr,
          icon: Icons.sunny_snowing,
        ),
        SalahModel(
          id: 4,
          name: 'العصر',
          time: DateFormat.jm().format(prayerTimes.asr),
          dateTime: prayerTimes.asr,
          icon: Icons.ac_unit,
        ),
        SalahModel(
          id: 5,
          name: 'المغرب',
          time: DateFormat.jm().format(prayerTimes.maghrib),
          dateTime: prayerTimes.maghrib,
          icon: Icons.nights_stay_rounded,
        ),
        SalahModel(
          id: 6,
          name: 'العشاء',
          time: DateFormat.jm().format(prayerTimes.isha),
          dateTime: prayerTimes.isha,
          icon: Icons.dark_mode_sharp,
        ),
      ]);
    }
    return salah;
  }
}
