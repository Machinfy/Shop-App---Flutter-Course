import 'package:shop_app/core/remote/network.dart';

class OrdersRemoteDataSource {
  final _networkService = NetworkService();

  Future<String> addOrderRawData({required Map<String, dynamic> data}) async {
    final responseData =
        await _networkService.post(path: 'orders.json', data: data);
    return responseData['name'] as String;
  }
}
