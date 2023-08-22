import 'package:flutter/material.dart';
import 'package:shop_app/features/products/presentation/screens/products_overview_screen.dart';
import 'package:shop_app/features/profile/presentation/screens/profile_tab.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shop App'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.shopify),
                text: 'Products',
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Favorites',
              ),
              Tab(
                icon: Icon(Icons.shopping_cart),
                text: 'Cart',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProductsOverviewTab(),
            SizedBox(),
            SizedBox(),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}
