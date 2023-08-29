import 'package:shop_app/core/network/remote/network_service.dart';
import 'package:shop_app/core/utils/constants.dart';

class AuthRemoteDataSource {
  final _networkService = NetworkService();

  Future<Map<String, dynamic>> singUpUserInServer(
      {required String email, required String password}) async {
    final responseData = await _networkService.post(
        path: kSignUpEndpoint,
        data: {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
        baseUrl: kAuthBaseUrl,
        queryParameters: {'key': kWebApiKey});

    return responseData;
  }

  Future<Map<String, dynamic>> loginUserInServer(
      {required String email, required String password}) async {
    final responseData = await _networkService.post(
        path: kLoginEndpoint,
        data: {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
        baseUrl: kAuthBaseUrl,
        queryParameters: {'key': kWebApiKey});

    return responseData;
  }
}
