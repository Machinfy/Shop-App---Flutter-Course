import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/products/logic/cubit/products_cubit.dart';
import 'package:shop_app/features/products/presentation/screens/manage_product_screen.dart';

import '../widgets/user_products_list.dart';

class UserProductsScreen extends StatefulWidget {
  const UserProductsScreen({super.key});

  static const routeName = '/managed-products';

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(ManageProductScreen.routeName),
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ProductsFailedToLoad) {
            return Center(
              child: Text(state.failureMsg),
            );
          }
          final products = context.read<ProductsCubit>().products;
          return UserProductsList(
            products: products,
          );
        },
      ),
    );
  }
}
