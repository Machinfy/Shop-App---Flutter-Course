part of 'orders_cubit.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersManagingLoading extends OrdersState {}

class OrdersManaged extends OrdersState {
  final Operation operation;

  OrdersManaged({required this.operation});
}

class OrdersFailedToBeManaged extends OrdersState {
  final Operation operation;
  final String failureMsg;

  OrdersFailedToBeManaged({required this.operation, required this.failureMsg});
}
