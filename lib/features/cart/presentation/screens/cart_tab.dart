import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/cart/data/models/cart_item.dart';
import 'package:shop_app/features/cart/logic/cubits/cart_cubit.dart';
import 'package:shop_app/features/orders/data/models/order.dart';
import 'package:shop_app/features/orders/logic/cubits/orders_cubit.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is OrdersManaged) {
          context.read<CartCubit>().clearCart();
          // Show SnackBar to notify that order has been created
        }
        if (state is OrdersFailedToBeManaged) {
          // Show SnackBar
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();
          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Chip(
                          label:
                              Text(cartCubit.totalAmount.toStringAsFixed(2))),
                      TextButton(
                          onPressed: cartCubit.items.isEmpty
                              ? null
                              : () {
                                  final order = Order(
                                      id: DateTime.now().toString(),
                                      totalAmount: cartCubit.totalAmount,
                                      dateTime: DateTime.now(),
                                      cartItems:
                                          cartCubit.items.values.toList());
                                  context
                                      .read<OrdersCubit>()
                                      .addNewOrder(addedOrder: order);
                                },
                          child: const Text('Order Now'))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: cartCubit.cartItemsQuantity,
                    itemBuilder: (context, index) => CartListItem(
                          cartItem: cartCubit.items.values.toList()[index],
                          productId: cartCubit.items.keys.toList()[index],
                        )),
              )
            ],
          );
        },
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  const CartListItem(
      {super.key, required this.cartItem, required this.productId});

  final CartItem cartItem;
  final String productId;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        child: const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(
            Icons.delete,
            size: 30,
          ),
        ),
      ),
      onDismissed: (dismissDirection) {
        if (dismissDirection == DismissDirection.endToStart) {
          context.read<CartCubit>().removeCartItem(productId);
        }
      },
      key: ValueKey(cartItem.id),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 30,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child:
                    FittedBox(child: Text(cartItem.price.toStringAsFixed(2))),
              ),
            ),
            title: Text(
              cartItem.title,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
                'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: FractionallySizedBox(
              widthFactor: 0.33,
              child: FittedBox(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<CartCubit>()
                              .decreaseCartItemQuantity(productId);
                        },
                        icon: const Icon(Icons.remove)),
                    Text(
                      cartItem.quantity.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                        onPressed: () {
                          context.read<CartCubit>().addCartItem(
                              productId: productId,
                              title: cartItem.title,
                              price: cartItem.price);
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
