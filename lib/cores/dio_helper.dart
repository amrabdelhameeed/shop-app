import 'package:dio/dio.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/main.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
        BaseOptions(baseUrl: "https://student.valuxapps.com/api/", headers: {
      "Content-Type": "application/json",
      "lang": "ar",
    }));
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      required String token}) async {
    dio!.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      "Authorization": token
    };
    return dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> realPutData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      required String token}) async {
    dio!.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      "Authorization": token
    };
    return await dio!.put(url, queryParameters: query, data: data);
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      required String token}) async {
    dio!.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio!.get(
      url,
      queryParameters: query,
    );
  }
}
