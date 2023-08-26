import 'package:bloc/bloc.dart';
import 'package:shop_app/core/utils/enums.dart';
import 'package:shop_app/features/products/data/models/product.dart';

import '../../data/repo/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final ProductsRepo _productsRepo = ProductsRepo();

  var _products = <Product>[];

  List<Product> get products => [..._products];

  Product findProductById(String id) =>
      _products.firstWhere((product) => product.id == id);

  void getProducts() async {
    emit(ProductsLoading());
    try {
      _products = await _productsRepo.getProducts();
      emit(ProductsLoaded(_products));
    } catch (error) {
      emit(ProductsFailedToLoad(error.toString()));
    }
  }

  void addNewProduct({required Product addedProduct}) async {
    emit(ProductManagingLoading());
    try {
      final addedProductInServer =
          await _productsRepo.addNewProduct(addedProduct);
      _products.add(addedProductInServer);
      emit(ProductManaged(Operation.add));
    } catch (error) {
      emit(ProductFailedToBeManaged(
          operation: Operation.add, failureMsg: error.toString()));
    }
  }

  void updateProduct({required Product updatedProduct}) async {
    emit(ProductManagingLoading());
    try {
      await _productsRepo.updateProduct(updatedProduct);
      final updatedProductIndex =
          _products.indexWhere((product) => product.id == updatedProduct.id);
      _products[updatedProductIndex] = updatedProduct;
      emit(ProductManaged(Operation.update));
    } catch (error) {
      emit(ProductFailedToBeManaged(
          operation: Operation.update, failureMsg: error.toString()));
    }
  }

  void deleteProduct({required Product deletedProduct}) async {
    _products.removeWhere((product) => product.id == deletedProduct.id);
    emit(ProductManaged(Operation.delete));
    try {
      await _productsRepo.deleteProduct(deletedProduct.id);
    } catch (error) {
      _products.add(deletedProduct);
      emit(ProductFailedToBeManaged(
          operation: Operation.delete, failureMsg: error.toString()));
    }
  }
}
