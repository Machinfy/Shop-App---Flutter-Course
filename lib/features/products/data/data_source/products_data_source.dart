import 'package:shop_app/core/remote/network.dart';

class ProductsDataSource {
  final _networkService = NetworkService();

  Future<Map<String, dynamic>> getProductsRawData() async {
    final responseData = await _networkService
        .get(path: 'products.json', queryParameters: {'auth': token});
    if (responseData == null) return {};
    return responseData as Map<String, dynamic>;
  }

  Future<String> addProductRawData({required Map<String, dynamic> data}) async {
    final responseData =
        await _networkService.post(path: 'products.json', data: data);
    return responseData['name'] as String;
  }

  Future<void> updateProductRawData(
      {required Map<String, dynamic> data, required String id}) async {
    return await _networkService.put(path: 'products/$id.json', data: data);
  }

  Future<void> deleteProductRawData({required String id}) async {
    return await _networkService.delete(path: 'products/$id.json');
  }
}
