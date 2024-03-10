import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/shared_preferences/app_prefs.dart';
import 'package:holly_quran/features/home/data/db_manger.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';
import 'package:holly_quran/features/home/data/models/tasbih/tasbih_model.dart';
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
    List<int> pages= [
      1,2,50,77,106,128,151,177,187,208,221,235,249,255,262,267,282,293,305,312,
      322,332,342,350,359,367,377,385,396,404,411,415,418,428,434,440,446,453,
      458,467,477,483,489,496,499,502,507,511,515,518,520,523,526,528,531,534,537,
      542,545,549,551,553,554,556,558,560,562,564,566,568,570,572,574,575,577,578,
      580,582,583,585,586,587,587,589,590,591,591,592,593,594,595,595,596,596,597,
      597,598,598,599,599,600,600,601,601,601,602,602,602,603,603,603,604,604,604,
    ];
    print('gg:${pages.length}');
    for (int i = 1; i <= quran.totalSurahCount; i++) {
      sours.add(
        SurahModel(
          id: i,
          name: i == 111 ? 'المسد':quran.getSurahNameArabic(i),
          type: arPlaceName(quran.getPlaceOfRevelation(i)),
          ayatNumber: quran.getVerseCount(i),
          pageNumber: pages[i -1],
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

  //***************************************************************************//

  // fetchTasbih
  @override
  Future<List<TasbihModel>> fetchTasbih() async {
    final db = await DatabaseManager().database;

    // Static list of TasbihModel objects
    List<TasbihModel> staticTasbihs = [
      TasbihModel(id: 0, name: "سبحان الله",type: '(بعد الصلاة)', counter: 33,static: true),
      TasbihModel(id: 0, name: "الحمد لله",type: '(بعد الصلاة)', counter: 33,static: true),
      TasbihModel(id: 0, name: "الله أكبر",type: '(بعد الصلاة)', counter: 33,static: true),
      TasbihModel(id: 0, name: "سبحان الله",type: '(باقيات صالحات)', counter: 100,static: true),
      TasbihModel(id: 0, name: "الحمدلله",type: '(باقيات صالحات)', counter: 100,static: true),
      TasbihModel(id: 0, name: "لا إله إلا الله",type: '(باقيات صالحات)', counter: 100,static: true),
      TasbihModel(id: 0, name: "الله اكبر",type: '(باقيات صالحات)', counter: 100,static: true),
      TasbihModel(id: 0, name: "لا حول ولا قوة إلا بالله",type: '(باقيات صالحات)', counter: 100,static: true),
      TasbihModel(id: 0, name: "سبحان الله وبحمده سبحان الله العظيم",type: '(باقيات صالحات)', counter: 100,static: true),
      // Add more static items as needed
    ];

    // Check if the tasbih table exists in the database
    if (!await DatabaseManager().doesTableExist('tasbih')) {
      return staticTasbihs;
    }

    // Query to select all rows from the tasbih table
    final List<Map<String, dynamic>> maps = await db.query('tasbih');

    // Converting each Map to a TasbihModel and combining with static list
    List<TasbihModel> tasbihsFromDb = maps.map((map) => TasbihModel.fromJson(map)).toList();
    return staticTasbihs + tasbihsFromDb;
  }



  // addOneTasbih
  @override
  Future<void> addOneTasbih({required String name, required int counter}) async {
    final db = await DatabaseManager().database;
    await db.insert(
      'tasbih',
      {'name': name, 'counter': counter},
    );
  }

  //updateTasbih
  @override
  Future<void> updateTasbih({required int id,required String name,required int counter}) async {
    final db = await DatabaseManager().database;
    // Update the existing tasbih record
    await db.update(
      'tasbih',
      {'name': name, 'counter': counter},
      where: 'id = ?', // Use the where clause to specify which record to update
      whereArgs: [id], // Pass the id as a where argument
    );
  }


  // removeOneSadaqa
  @override
  Future<void> removeOneTasbih({required int tasbihId}) async {

    final db = await DatabaseManager().database;

    // Delete the specified tasbih record
    await db.delete(
      'tasbih',
      where: 'id = ?',
      whereArgs: [tasbihId],
    );
  }
}
