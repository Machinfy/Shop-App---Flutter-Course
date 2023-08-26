import 'package:shop_app/features/cart/data/models/cart_item.dart';

class Order {
  final String id;
  final double totalAmount;
  final DateTime dateTime;
  final List<CartItem> cartItems;

  Order({
    required this.id,
    required this.totalAmount,
    required this.dateTime,
    required this.cartItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: '', totalAmount: 0, dateTime: DateTime.now(), cartItems: []);
  }

  factory Order.fromAddedOrder(
      {required Order addedOrder, required String generatedIdFromServer}) {
    return Order(
        id: generatedIdFromServer,
        totalAmount: addedOrder.totalAmount,
        dateTime: addedOrder.dateTime,
        cartItems: addedOrder.cartItems);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalAmount': totalAmount,
      'dateTime': dateTime.toIso8601String(),
      'cartItems': cartItems
          .map((cartItem) => {
                'id': cartItem.id,
                'title': cartItem.title,
                'price': cartItem.price,
                'quantity': cartItem.quantity,
              })
          .toList()
    };
  }
}
