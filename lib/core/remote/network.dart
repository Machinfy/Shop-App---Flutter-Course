import 'package:dio/dio.dart';

const token =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjYzODBlZjEyZjk1ZjkxNmNhZDdhNGNlMzg4ZDJjMmMzYzIzMDJmZGUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc2hvcC1hcHBsaWNhdGlvbi1mbHV0dGVyLTNhOTlhIiwiYXVkIjoic2hvcC1hcHBsaWNhdGlvbi1mbHV0dGVyLTNhOTlhIiwiYXV0aF90aW1lIjoxNjkyNDcwMjk5LCJ1c2VyX2lkIjoiNlk0QUFnOXZRVVcxYnJFWkVzUG5oMlBQSDVHMyIsInN1YiI6IjZZNEFBZzl2UVVXMWJyRVpFc1BuaDJQUEg1RzMiLCJpYXQiOjE2OTI0NzAyOTksImV4cCI6MTY5MjQ3Mzg5OSwiZW1haWwiOiJ0ZXN0QHRlc3QuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInRlc3RAdGVzdC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.cAr2f3zEjdzU_dvWY_w11U-8uT7qtDoUFDPPWxOI4FcLV0KoMxIEBgZ2AUFmqd-4I_Ev9Ee9tBq6GpX0oQildYZKklrceinpZQJHJOLb8-DBgcokl7xHjAW3FI4lq3uXf39ZY1rYpsW4IqAna-GZJmEkw_A2jsiHMUC7Cv47mXS13MbxHQ4-KTxPSCLIYOAZ2Ya1xjtelxkaq73afaqsnVhFmScB521ZSORgztIEUOTm_PEUCe_phlBvje1a9s5qfCJHxYLfCck0yMD6TKS9TvbGBNUWfbglg19Zc7lggsFOw-dBBGFOpZg178_VC7VHZ2hGa1bcwRe8pDw1ocUCrw';

class NetworkService {
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
      baseUrl: 'https://shop-app-machinfy-default-rtdb.firebaseio.com/',
    ));
  }

  Future<dynamic> get(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    _init();
    final response = await _dio!.get(path, queryParameters: queryParameters);
    return response.data;
  }

  Future<dynamic> post(
      {required String path,
      Map<String, dynamic>? queryParameters,
      required Map<String, dynamic> data}) async {
    _init();
    final response =
        await _dio!.post(path, queryParameters: queryParameters, data: data);
    return response.data;
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
