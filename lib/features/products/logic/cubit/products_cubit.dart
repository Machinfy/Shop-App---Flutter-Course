import 'package:bloc/bloc.dart';
import 'package:shop_app/core/utils/enums.dart';
import 'package:shop_app/features/products/data/models/product.dart';

import '../../data/repo/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final ProductsRepo productsRepo = ProductsRepo();

  var _products = <Product>[];

  List<Product> get products => [..._products];

  void getProducts() async {
    emit(ProductsLoading());
    try {
      _products = await productsRepo.getProducts();
      emit(ProductsLoaded(_products));
    } catch (error) {
      emit(ProductsFailedToLoad(error.toString()));
    }
  }

  void addNewProduct({required Product addedProduct}) async {
    emit(ProductManagingLoading());
    try {
      final addedProductInServer =
          await productsRepo.addNewProduct(addedProduct);
      _products.add(addedProductInServer);
      emit(ProductManaged(Operation.add));
    } catch (error) {
      emit(ProductFailedToBeManaged(
          operation: Operation.add, failureMsg: error.toString()));
    }
  }
}
