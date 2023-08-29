import 'dart:convert';

import 'package:shop_app/core/network/local/cache_service.dart';

class AuthLocalDataSource {
  Future<void> saveAuthRawData({required Map<String, dynamic> data}) async {
    final encodedData = jsonEncode(data);
    await CacheService.setData(key: 'userData', value: encodedData);
  }

  Map<String, dynamic>? get authRawData {
    if (!CacheService.contains(key: 'userData')) return null;
    final encodeData = CacheService.getData(key: 'userData');
    final decodedData = jsonDecode(encodeData);
    return decodedData;
  }

  void removeAuthDataFromCache() {
    if (!CacheService.contains(key: 'userData')) return;
    CacheService.removeWith(key: 'userData');
  }
}
