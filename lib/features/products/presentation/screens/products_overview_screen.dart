import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/products/logic/cubit/products_cubit.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewTab extends StatefulWidget {
  const ProductsOverviewTab({super.key});

  @override
  State<ProductsOverviewTab> createState() => _ProductsOverviewTabState();
}

class _ProductsOverviewTabState extends State<ProductsOverviewTab> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
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
        return ProductsGrid(
          products: products,
        );
      },
    );
  }
}
