import 'package:bloc/bloc.dart';
import 'package:shop_app/features/cart/data/models/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  void addCartItem(
      {required String productId,
      required String title,
      required double price}) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      final cartItem = CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price);
      _items.putIfAbsent(productId, () => cartItem);
      //_items[productId] = cartItem;
    }
    emit(CartManagedState());
  }

  void decreaseCartItemQuantity(String productId) {
    if (!_items.containsKey(productId)) return;
    _items.update(
        productId,
        (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
            ));
    if (_items[productId]!.quantity == 0) _items.remove(productId);
    emit(CartManagedState());
  }

  void removeCartItem(String productId) {
    _items.remove(productId);
    emit(CartManagedState());
  }

  int get cartItemsQuantity {
    return _items.length;
  }

  int get totalCartQuantity {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  double get totalAmount {
    var totalAmount = 0.0;
    _items.forEach((key, value) {
      totalAmount += (value.price * value.quantity);
    });
    return totalAmount;
  }

  void clearCart() {
    _items.clear();
    emit(CartManagedState());
  }
}
