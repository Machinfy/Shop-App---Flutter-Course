import 'package:shop_app/features/products/data/data_source/products_data_source.dart';
import 'package:shop_app/features/products/data/models/product.dart';

class ProductsRepo {
  final productsDataSource = ProductsDataSource();

  Future<List<Product>> getProducts() async {
    final productsRawData = await productsDataSource.getProductsRawData();

    final List<Product> products = [];

    productsRawData.forEach((productId, productData) {
      products.add(Product.fromJson(productId, productData));
    });
    print('From Products Repo');

    print(products);
    return products;
  }

  Future<Product> addNewProduct(Product addedProduct) async {
    final generatedIdFromServer =
        await productsDataSource.addProductRawData(data: addedProduct.toJson());

    print(generatedIdFromServer);

    // return Product(
    //     id: generatedIdFromServer,
    //     title: addedProduct.title,
    //     description: addedProduct.description,
    //     price: addedProduct.price,
    //     imageUrl: addedProduct.imageUrl);
    return Product.fromAddedProduct(
        addedProduct: addedProduct, idFromServer: generatedIdFromServer);
  }
}
