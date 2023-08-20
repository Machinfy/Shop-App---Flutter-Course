import 'package:shop_app/core/remote/network.dart';

class ProductsDataSource {
  final networkService = NetworkService();

  Future<Map<String, dynamic>> getProductsRawData() async {
    final responseData = await networkService
        .get(path: 'products.json', queryParameters: {'auth': token});
    print('From Products DataSource');

    print(responseData);
    if (responseData == null) return {};
    return responseData as Map<String, dynamic>;
  }

  Future<String> addProductRawData({required Map<String, dynamic> data}) async {
    final responseData =
        await networkService.post(path: 'products.json', data: data);
    print(responseData);

    return responseData['name'] as String;
  }
}
