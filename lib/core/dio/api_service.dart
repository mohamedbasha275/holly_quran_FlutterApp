import 'package:dio/dio.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class ApiService{
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio;
  ApiService(this._dio);

  Map<String, String> headers = {
    CONTENT_TYPE: APPLICATION_JSON,
    ACCEPT: APPLICATION_JSON,
    AUTHORIZATION: 'Constants.token',
    DEFAULT_LANGUAGE: 'language'
  };

  Future<Map<String,dynamic>> get({required String url}) async{
    var response = await _dio.get('$_baseUrl$url',options: Options(headers: headers));
    return response.data;
  }
}