import 'package:shop_app/core/network/remote/network_service.dart';
import 'package:shop_app/core/utils/constants.dart';

class ProductsDataSource {
  final _networkService = NetworkService();

  Future<Map<String, dynamic>> getProductsRawData() async {
    final responseData = await _networkService.get(
        path: '$kProductsApiEndPoint.json',
        queryParameters: {'auth': userToken});
    if (responseData == null) return {};
    return responseData as Map<String, dynamic>;
  }

  Future<String> addProductRawData({required Map<String, dynamic> data}) async {
    final responseData = await _networkService.post(
        path: '$kProductsApiEndPoint.json',
        data: data,
        queryParameters: {'auth': userToken});
    return responseData['name'] as String;
  }

  Future<void> updateProductRawData(
      {required Map<String, dynamic> data, required String id}) async {
    return await _networkService.put(
        path: '$kProductsApiEndPoint/$id.json',
        data: data,
        queryParameters: {'auth': userToken});
  }

  Future<void> deleteProductRawData({required String id}) async {
    return await _networkService.delete(
        path: '$kProductsApiEndPoint/$id.json',
        queryParameters: {'auth': userToken});
  }
}
