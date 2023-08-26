import 'package:shop_app/features/orders/data/data_source/orders_remote_data_source.dart';
import 'package:shop_app/features/orders/data/models/order.dart';

class OrdersRepo {
  final _ordersRemoteDataSource = OrdersRemoteDataSource();

  Future<Order> addNewOrder(Order addedOrder) async {
    final generatedIdFromServer = await _ordersRemoteDataSource.addOrderRawData(
        data: addedOrder.toJson());

    return Order.fromAddedOrder(
        addedOrder: addedOrder, generatedIdFromServer: generatedIdFromServer);
  }
}
