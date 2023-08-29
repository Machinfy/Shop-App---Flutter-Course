import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/network/local/cache_service.dart';
import 'package:shop_app/features/authentication/logic/cubits/auth_cubit.dart';
import 'package:shop_app/features/authentication/presentation/screens/auth_screen.dart';

import '/features/cart/logic/cubits/cart_cubit.dart';
import '/features/orders/logic/cubits/orders_cubit.dart';
import '/features/products/logic/cubit/products_cubit.dart';
import '/features/products/presentation/screens/manage_product_screen.dart';
import '/features/products/presentation/screens/user_products_screen.dart';
import '/layout/app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthCubit>(create: (context) {
        //   final authCubit = AuthCubit();
        //   authCubit.tryAutoLogin();
        //   return authCubit;
        // }),
        BlocProvider<AuthCubit>(
            create: (context) => AuthCubit()..tryAutoLogin()),

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
        home: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final auth = context.read<AuthCubit>().auth;
            print(state);
            return auth == null ? const AuthScreen() : const AppLayout();
          },
        ),
        routes: {
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
          ManageProductScreen.routeName: (context) =>
              const ManageProductScreen(),
        },
      ),
    );
  }
}
