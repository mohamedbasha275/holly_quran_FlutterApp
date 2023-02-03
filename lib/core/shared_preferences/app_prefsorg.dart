//
//
// import 'dart:convert';
// import 'dart:developer';
//
//
// import 'package:aljwab_cleint/features/data/model/response/driver_transaction/driver_transactions_response.dart';
// import 'package:aljwab_cleint/features/data/model/response/home/home_response.dart';
// import 'package:aljwab_cleint/features/data/model/response/map/map_response.dart';
// import 'package:aljwab_cleint/features/domain/entities/driver_maintaince.dart';
// import 'package:aljwab_cleint/features/domain/entities/locations_search.dart';
// import 'package:aljwab_cleint/features/domain/entities/logout.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../features/data/model/response/auth/auth_response.dart';
// import '../../features/data/model/response/driver_orders/driver_orders_response.dart';
// import '../resources/app_constant.dart';
// import '../extension/extension.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// abstract class AppSettingPreferences {
//
//   //setting app local data
//
//   Future<bool> setAppLanguage(String value);
//   Future<bool> setAppTheme(String value);
//   Future<bool> setAppOnBoardingISViewed(bool value);
//   String getAppLanguage();
//   String getAppTheme();
//   bool getAppOnBoardingIsViewed();
//
//   //auth app local data
//
//   bool getAppUserISLoggedIn();
//   Future<AuthenticationResponse> getUserData();
//
//   Future<bool> setUserAuthentication(String value);
//   Future<bool> setAppUserISLoggedIn(bool value);
//   Future<LogoutAuthResponse> logout();
//
//   //order operation data
//   Future<bool> cashBooking(String value);
//   Future<DriverBookingPaginationResponse> getBooking();
//
//   Future<bool> cashOrder(String value);
//   Future<DriverOrdersPaginationResponse> getOrder();
//   //city order
//   Future<bool> cashCityOrder(String value);
//   Future<DriverOrdersPaginationResponse> getCityOrder();
//
//   //transactions
//   Future<bool> cashTransactions(String value);
//   Future<DriverTransactionsPaginationResponse> getTransactions();
//   //covenant
//   Future<bool> cashDriverCovenant(String  value);
//
//   //maintain_app
//   Future<bool> cashDriverMaintain(String  value);
//
//   //home
//   Future<bool> cashHome(String  value);
//   Future<HomeDataResponse> getHome();
//   //cash fav location
//
//   Future<bool> cashFavLocation(List<Predictions>  value);
//   Future<LocationSearchDataResponse> getFavLocation();
//
//
//
// }
//
//
// class AppSettingPreferencesImpl implements AppSettingPreferences {
//
//   final SharedPreferences appPref;
//
//   AppSettingPreferencesImpl(this.appPref);
//
// ///////////////////////////////////////  setting app lang and theme  view onBoarding /////////////////////////////////////////////////////
//   @override
//   String getAppLanguage() =>
//       appPref.getString(AppConstants.appLanguagePrefsKey).orLengthZero(
//           empty: AppConstants.defaultLanguageAppCode);
//
//   @override
//   String getAppTheme() =>
//       appPref.getString(AppConstants.appThemeModePrefsKey).orLengthZero(
//           empty: AppConstants.defaultThemeModeApp);
//
//   @override
//   bool getAppOnBoardingIsViewed() =>
//       appPref.getBool(AppConstants.appOnBoardingIsViewedPrefsKey).orBoolInit();
//
//   @override
//   Future<bool> setAppLanguage(String value) async =>
//       await appPref.setString(AppConstants.appLanguagePrefsKey, value);
//
//   @override
//   Future<bool> setAppOnBoardingISViewed(bool value) async =>
//       await appPref.setBool(AppConstants.appOnBoardingIsViewedPrefsKey, value);
//
//   @override
//   Future<bool> setAppTheme(String value) async =>
//       await appPref.setString(AppConstants.appThemeModePrefsKey, value);
//
//
//   //////////////////////////////////////  auth operation //////////////////////////////////
//
//
//   @override
//   Future<bool> setAppUserISLoggedIn(bool value) async =>
//       await appPref.setBool(AppConstants.appUserIsLoggedInPrefsKey, value);
//
//   @override
//   bool getAppUserISLoggedIn() =>
//       appPref.getBool(AppConstants.appUserIsLoggedInPrefsKey).orBoolInit();
//
//   @override
//   Future<bool> setUserAuthentication(String value) async {
//     await setAppUserISLoggedIn(true);
//     return await appPref.setString(
//         AppConstants.appCashedAuthenticationResponse, value);
//   }
//
//   @override
//   Future<AuthenticationResponse> getUserData() async {
//     final authUser = appPref.getString(
//         AppConstants.appCashedAuthenticationResponse);
//     return AuthenticationResponse.fromJson(
//         json.decode(authUser!) as Map<String, dynamic>);
//   }
//
//
//   @override
//   Future<LogoutAuthResponse> logout() async {
//     final lang=getAppLanguage();
//     final theme= getAppTheme();
//     await appPref.clear();
//     await setAppLanguage(lang);
//     await setAppTheme(theme);
//     await setAppOnBoardingISViewed(true);
//     return LogoutAuthResponse(true);
//   }
//
// //////////////////////////////////     order  operation               /////////////////////////////////////////////////////
//
//   //order
//   @override
//   Future<bool> cashOrder(String value) async
//   {
//     return await appPref.setString(AppConstants.appCashedDriverOrderSDataResponse, value);
//   }
//
//   @override
//   Future<DriverOrdersPaginationResponse> getOrder() async {
//     final order = appPref.getString(
//         AppConstants.appCashedDriverOrderSDataResponse);
//
//     return DriverOrdersPaginationResponse.fromJson(
//         json.decode(order.orEmptyPaginationJson()) as Map<String, dynamic>);
//   }
//   //city
//   @override
//   Future<bool> cashCityOrder(String value) async
//   {
//     return await appPref.setString(
//         AppConstants.appCashedDriverCityOrderSDataResponse, value);
//   }
//
//   @override
//   Future<DriverOrdersPaginationResponse> getCityOrder() async {
//     final order = appPref.getString(
//         AppConstants.appCashedDriverCityOrderSDataResponse);
//
//     return DriverOrdersPaginationResponse.fromJson(
//         json.decode(order.orEmptyPaginationJson()) as Map<String, dynamic>);
//   }
//
//   //////////////////////////////////     order  operation               /////////////////////////////////////////////////////
//
//   //transaction
//   @override
//   Future<bool> cashTransactions(String value) async
//   {
//     return await appPref.setString(AppConstants.appCashedDriverTransactionsDataResponse, value);
//   }
//
//   @override
//   Future<DriverTransactionsPaginationResponse> getTransactions() async {
//     final transaction = appPref.getString(
//         AppConstants.appCashedDriverTransactionsDataResponse);
//     return DriverTransactionsPaginationResponse.fromJson(
//         json.decode(transaction.orEmptyPaginationJson()) as Map<String, dynamic>);
//   }
//
//   //covenant
//   @override
//   Future<bool> cashDriverCovenant(String value) async
//   {
//     return await appPref.setString(AppConstants.appCashedDriverCovenantSDataResponse, value);
//   }
//
//
//
//   //maintain_app
//   @override
//   Future<bool> cashDriverMaintain(String value) async
//   {
//     return await appPref.setString(AppConstants.appCashedDriverMaintainDataResponse, value);
//   }
//
//
//   //home
//   //maintain_app
//   @override
//   Future<bool> cashHome(String value) async
//   {
//     return await appPref.setString(AppConstants.appCashedHomeDataResponse, value);
//   }
//
//   @override
//   Future<HomeDataResponse> getHome() async {
//     final homeData = appPref.getString(AppConstants.appCashedHomeDataResponse);
//     return HomeDataResponse.fromJson(json.decode(homeData.orEmptyJsonHome()) as Map<String, dynamic>);
//   }
//
//   @override
//   Future<bool> cashFavLocation(List<Predictions> value) async{
//     try {
//       List<PredictionsResponse> item = value.map((e) =>
//           PredictionsResponse(e.description, e.placeId, e.reference,
//               StructuredFormattingResponse(e.structuredFormatting.mainText,
//                   e.structuredFormatting.secondaryText))).toList();
//       LocationSearchDataResponse locationSearchDataResponse = LocationSearchDataResponse(
//           item, "Ok");
//       log(locationSearchDataResponse.toJson().toString() +
//           "---------11111111111111111111111111111111----------");
//
//       return await appPref.setString(
//           AppConstants.appCashedFavLocationDataResponse,
//           jsonEncode(locationSearchDataResponse.toJson()));
//
//     }catch(e)
//     {
//       log(e.toString() +
//           "---------11111111111111111111111111111111----------");
//       throw e;
//     }
//
//     }
//
//   @override
//   Future<LocationSearchDataResponse> getFavLocation() async{
//     final homeData = appPref.getString(AppConstants.appCashedFavLocationDataResponse);
//
//     return LocationSearchDataResponse.fromJson(json.decode(homeData.orEmptyJsonLocation()) as Map<String, dynamic>);
//   }
//
//
//   ////////
//   @override
//   Future<bool> cashBooking(String value) async
//   {
//     return await appPref.setString(AppConstants.appCashedDriverBookingDataResponse, value);
//   }
//
//   @override
//   Future<DriverBookingPaginationResponse> getBooking() async {
//     final booking = appPref.getString(AppConstants.appCashedDriverBookingDataResponse);
//     return DriverBookingPaginationResponse.fromJson(json.decode(booking.orEmptyPaginationJson()) as Map<String, dynamic>);
//   }
// }
