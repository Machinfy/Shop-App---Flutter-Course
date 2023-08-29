import 'package:shop_app/core/network/remote/network_service.dart';
import 'package:shop_app/core/utils/constants.dart';

class OrdersRemoteDataSource {
  final _networkService = NetworkService();

  Future<String> addOrderRawData({required Map<String, dynamic> data}) async {
    final responseData = await _networkService.post(
        path: '$kOrdersApiEndPoint.json',
        data: data,
        queryParameters: {'auth': userToken});
    return responseData['name'] as String;
  }
}
