import 'dart:convert';
import 'dart:ui';
import 'package:holly_quran/core/resources/langauge_manager.dart';
import 'package:holly_quran/features/daily_werd/data/models/werd.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
//************************************************************************/
const String STOP_READING_KEY = 'STOP_READING_KEY';
const String SADAQAT_LIST = 'SADAQAT_LIST';
const String WERDS_LIST = 'WERDS_LIST';
const String CURRENT_LOCATION_KEY = 'CURRENT_LOCATION_KEY';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default language
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.ARABIC.getValue()) {
      // set english
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      // set arabic
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.ARABIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  // on boarding

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
        false;
  }

  //login

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }

  //***************************************************************************//
  // stop read surah
  Future<void> setStopReading(
      {required int surah,
      required int page,
      required String surahName}) async {
    _sharedPreferences
        .setStringList(STOP_READING_KEY, ['$surah', '$page', surahName]);
  }

  Future<List<String>> getStopReading() async {
    List<String>? stop = _sharedPreferences.getStringList(STOP_READING_KEY);
    if (stop != null && stop.length >= 3) {
      return stop;
    } else {
      return ['1', '1', 'الفاتحة'];
    }
  }

  // sadaqat
  Future<void> addOnSadaqa({required String name}) async {
    List<String> sadaqat = [];
    if (_sharedPreferences.getStringList(SADAQAT_LIST) != null) {
      sadaqat = _sharedPreferences.getStringList(SADAQAT_LIST)!;
    }
    sadaqat.add(name);
    _sharedPreferences.setStringList(SADAQAT_LIST, sadaqat);
  }

  Future<void> removeOneSadaqa({required int index}) async {
    List<String>? sadaqat = _sharedPreferences.getStringList(SADAQAT_LIST);
    sadaqat!.removeAt(index);
    _sharedPreferences.setStringList(SADAQAT_LIST, sadaqat);
  }

  Future<List<String>> getAllSadaqat() async {
    List<String>? sadaqat = _sharedPreferences.getStringList(SADAQAT_LIST);
    if (sadaqat != null) {
      return sadaqat;
    } else {
      return [];
    }
  }

  // salah
  Future<void> setCurrentLocation(
      {required double lat, required double long}) async {
    _sharedPreferences.remove(CURRENT_LOCATION_KEY);
    _sharedPreferences.setStringList(CURRENT_LOCATION_KEY, ['$lat', '$long']);
  }

  Future<List<String>> getCurrentLocation() async {
    List<String>? salah =
        _sharedPreferences.getStringList(CURRENT_LOCATION_KEY);
    if (salah != null) {
      return salah;
    } else {
      return [];
    }
  }

  // Dail Werd
  Future<List<WerdModel>> getAllWerd() async {
    String? storedData = _sharedPreferences.getString(WERDS_LIST);
    if (storedData == null) {
      return [];
    }
    List<dynamic> extracted = json.decode(storedData);
    return extracted.map((item) => WerdModel.fromJson(item)).toList();
  }
  Future<void> addOnWerd({required String name}) async {
    List<WerdModel> werds = [];
    String? storedData = _sharedPreferences.getString(WERDS_LIST);
    if (storedData != null) {
      werds = (json.decode(storedData) as List)
          .map((item) => WerdModel.fromJson(item))
          .toList();
    }
    werds.add(WerdModel(title: name, done: false));
    String encoded = json.encode(werds.map((werd) => werd.toJson()).toList());
    await _sharedPreferences.setString(WERDS_LIST, encoded);
  }
  Future<void> removeOnWerd({required int index}) async {
    List<WerdModel> werds = await getAllWerd();
    werds.removeAt(index);
    String encoded = json.encode(werds.map((werd) => werd.toJson()).toList());
    await _sharedPreferences.setString(WERDS_LIST, encoded);
  }
  Future<void> updateWerd({required int index}) async {
    final storedData = _sharedPreferences.getString(WERDS_LIST);
    if (storedData == null) return;
    final extracted = json.decode(storedData) as List<dynamic>;
    final werds = extracted
        .map((item) => WerdModel(title: item['title'], done: item['done']))
        .toList();
    // Update the done value of the WerdModel object at the specified index
    werds[index] = werds[index].copyWith(done: true);
    final encoded = json.encode(werds.map((werd) => werd.toJson()).toList());
    await _sharedPreferences.setString(WERDS_LIST, encoded);
  }

  Future<void> updateAllWerd() async {
    List<WerdModel> werds = await getAllWerd();
    // Update the done value of all WerdModel objects to false
    werds = werds.map((werd) => werd.copyWith(done: false)).toList();
    String encoded = json.encode(werds.map((werd) => werd.toJson()).toList());
    await _sharedPreferences.setString(WERDS_LIST, encoded);
  }
}
