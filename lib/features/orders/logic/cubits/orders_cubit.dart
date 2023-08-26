import 'package:bloc/bloc.dart';
import 'package:shop_app/core/utils/enums.dart';
import 'package:shop_app/features/orders/data/repo/orders_repo.dart';

import '../../data/models/order.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  final _ordersRepo = OrdersRepo();
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addNewOrder({required Order addedOrder}) async {
    emit(OrdersManagingLoading());
    try {
      final addedOrderInServer = await _ordersRepo.addNewOrder(addedOrder);
      _orders.add(addedOrderInServer);
      emit(OrdersManaged(operation: Operation.add));
    } catch (error) {
      emit(OrdersFailedToBeManaged(
          operation: Operation.add, failureMsg: error.toString()));
    }
  }
}
