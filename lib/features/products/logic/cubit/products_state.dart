part of 'products_cubit.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductsFailedToLoad extends ProductsState {
  final String failureMsg;

  ProductsFailedToLoad(this.failureMsg);
}

class ProductManagingLoading extends ProductsState {}

class ProductManaged extends ProductsState {
  final Operation operation;

  ProductManaged(this.operation);
}

class ProductFailedToBeManaged extends ProductsState {
  final Operation operation;
  final String failureMsg;

  ProductFailedToBeManaged({required this.operation, required this.failureMsg});
}
