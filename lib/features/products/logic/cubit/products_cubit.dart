import 'package:bloc/bloc.dart';
import 'package:shop_app/features/products/data/models/product.dart';

import '../../data/repo/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final ProductsRepo productsRepo = ProductsRepo();

  var products = <Product>[];

  void getProducts() async {
    products = await productsRepo.getProducts();
    print(products);
  }

  void addNewProduct({required Product addedProduct}) async {
    final addedProductInServer = await productsRepo.addNewProduct(addedProduct);

    products.add(addedProductInServer);
    print('From Products Cubit');

    print(addedProductInServer);
  }
}
