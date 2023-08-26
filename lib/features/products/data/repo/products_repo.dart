import 'package:shop_app/features/products/data/data_source/products_data_source.dart';
import 'package:shop_app/features/products/data/models/product.dart';

class ProductsRepo {
  final _productsDataSource = ProductsDataSource();

  Future<List<Product>> getProducts() async {
    final productsRawData = await _productsDataSource.getProductsRawData();

    final List<Product> products = [];

    productsRawData.forEach((productId, productData) {
      products.add(Product.fromJson(productId, productData));
    });
    return products;
  }

  Future<Product> addNewProduct(Product addedProduct) async {
    final generatedIdFromServer = await _productsDataSource.addProductRawData(
        data: addedProduct.toJson());

    // return Product(
    //     id: generatedIdFromServer,
    //     title: addedProduct.title,
    //     description: addedProduct.description,
    //     price: addedProduct.price,
    //     imageUrl: addedProduct.imageUrl);
    return Product.fromAddedProduct(
        addedProduct: addedProduct, idFromServer: generatedIdFromServer);
  }

  Future<void> updateProduct(Product updatedProduct) async {
    return await _productsDataSource.updateProductRawData(
        data: updatedProduct.toJson(), id: updatedProduct.id);
  }

  Future<void> deleteProduct(String deletedProductId) async {
    return await _productsDataSource.deleteProductRawData(id: deletedProductId);
  }
}
