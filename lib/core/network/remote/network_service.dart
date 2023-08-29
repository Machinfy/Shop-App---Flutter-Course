import 'package:dio/dio.dart';
import 'package:shop_app/core/utils/constants.dart';

class NetworkService {
  //TODO:- Singleton Design Pattern
  Dio? _dio;
  void _init() {
    // if (dio == null)
    //   dio = Dio(BaseOptions(
    //     connectTimeout: const Duration(seconds: 60),
    //     receiveTimeout: const Duration(seconds: 60),
    //     baseUrl: '',
    //
    //   ));
    //
    _dio ??= Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      baseUrl: kBaseUrl,
    ));
  }

  Future<dynamic> get(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    _init();
    _dio!.options.headers = {'auth': userToken};
    final response = await _dio!.get(path, queryParameters: queryParameters);
    return response.data;
  }

  Future<dynamic> post(
      {required String path,
      Map<String, dynamic>? queryParameters,
      required Map<String, dynamic> data,
      String? baseUrl}) async {
    _init();

    _dio!.options.baseUrl = baseUrl ?? _dio!.options.baseUrl;
    try {
      final response = await _dio!.post(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      // _dio!.options.baseUrl = kBaseUrl;
      return response.data;
    } catch (_) {
      rethrow;
    } finally {
      _dio!.options.baseUrl = kBaseUrl;
    }
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
  }) async {
    _init();
    final response = await _dio!.put(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    return response.data;
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    _init();
    final response =
        await _dio!.delete(path, queryParameters: queryParameters, data: data);
    return response.data;
  }
}
