import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/cart/logic/cubits/cart_cubit.dart';

import '../../data/models/product.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.products});

  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5 / 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductGridItem(
        product: products[index],
      ),
    );
  }
}

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: GridTile(
        footer: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
          child: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            title: Text(product.title),
            trailing: IconButton(
              onPressed: () {
                context.read<CartCubit>().addCartItem(
                    productId: product.id,
                    title: product.title,
                    price: product.price);
              },
              icon: const Icon(Icons.add_shopping_cart_outlined),
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
