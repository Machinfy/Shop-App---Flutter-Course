import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/cart/logic/cubits/cart_cubit.dart';
import 'package:shop_app/features/orders/logic/cubits/orders_cubit.dart';
import 'package:shop_app/features/products/logic/cubit/products_cubit.dart';
import 'package:shop_app/features/products/presentation/screens/manage_product_screen.dart';
import 'package:shop_app/features/products/presentation/screens/user_products_screen.dart';
import 'package:shop_app/layout/app_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(create: (context) => ProductsCubit()),
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
        BlocProvider<OrdersCubit>(create: (context) => OrdersCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AppLayout(),
        routes: {
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
          ManageProductScreen.routeName: (context) =>
              const ManageProductScreen(),
        },
      ),
    );
  }
}
