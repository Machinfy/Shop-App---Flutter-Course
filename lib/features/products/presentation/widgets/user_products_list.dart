import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/products/logic/cubit/products_cubit.dart';
import 'package:shop_app/features/products/presentation/screens/manage_product_screen.dart';

import '../../data/models/product.dart';

class UserProductsList extends StatelessWidget {
  const UserProductsList({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) =>
          UserProductsListItem(userProduct: products[index]),
    );
  }
}

class UserProductsListItem extends StatelessWidget {
  const UserProductsListItem({super.key, required this.userProduct});

  final Product userProduct;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 65,
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(userProduct.imageUrl),
            ),
            title: Text(userProduct.title),
            trailing: FractionallySizedBox(
              widthFactor: 0.27,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                          ManageProductScreen.routeName,
                          arguments: {'updatedProductId': userProduct.id}),
                      icon: const Icon(Icons.edit)),
                  IconButton(
                    onPressed: () {
                      context
                          .read<ProductsCubit>()
                          .deleteProduct(deletedProduct: userProduct);
                    },
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
