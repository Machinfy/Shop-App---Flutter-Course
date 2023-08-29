import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static late SharedPreferences sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    switch (value.runtimeType) {
      case int:
        return await sharedPreferences.setInt(key, value);
      case double:
        return await sharedPreferences.setDouble(key, value);
      case String:
        return await sharedPreferences.setString(key, value);
      case bool:
        return await sharedPreferences.setBool(key, value);
      default:
        throw Exception('Unsupported data type');
    }
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeWith({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static bool contains({required key}) {
    return sharedPreferences.containsKey(key);
  }
}
