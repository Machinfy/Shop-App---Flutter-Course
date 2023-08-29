import 'dart:async';

import 'package:shop_app/features/authentication/data/data_source/auth_local_data_source.dart';
import 'package:shop_app/features/authentication/data/data_source/auth_remote_data_source.dart';

import '../models/auth.dart';

class AuthRepo {
  final _remoteDataSource = AuthRemoteDataSource();
  final _cacheLocalDataSource = AuthLocalDataSource();

  Future<Auth> createUser(
      {required String email, required String password}) async {
    final responseData = await _remoteDataSource.singUpUserInServer(
        email: email, password: password);
    print(responseData['expiresIn']);
    _cacheLocalDataSource.saveAuthRawData(data: responseData);
    return Auth.fromJson(responseData);
  }

  Future<Auth> loginUser(
      {required String email, required String password}) async {
    final responseData = await _remoteDataSource.loginUserInServer(
        email: email, password: password);
    print(responseData['expiresIn']);
    _cacheLocalDataSource.saveAuthRawData(data: responseData);

    return Auth.fromJson(responseData);
  }

  Auth? tryAutoLogin() {
    final authRawData = _cacheLocalDataSource.authRawData;
    if (authRawData == null) return null;
    return Auth.fromJson(authRawData);
  }

  void removeAuthData() => _cacheLocalDataSource.removeAuthDataFromCache();
}
