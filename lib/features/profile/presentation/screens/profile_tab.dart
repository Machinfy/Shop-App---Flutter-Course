import 'package:flutter/material.dart';
import 'package:shop_app/features/products/presentation/screens/user_products_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const ProfileTabListTitle(
            title: 'Hello Aasem',
            leadingIcon: Icons.person,
          ),
          const Divider(),
          const ProfileTabListTitle(
            title: 'Orders',
            leadingIcon: Icons.shopify_sharp,
          ),
          const Divider(),
          ProfileTabListTitle(
            title: 'Your products',
            onPressed: () =>
                Navigator.of(context).pushNamed(UserProductsScreen.routeName),
            leadingIcon: Icons.settings,
          ),
          const Divider(),
          const ProfileTabListTitle(
            title: 'Logout',
            leadingIcon: Icons.logout,
          ),
        ],
      ),
    );
  }
}

class ProfileTabListTitle extends StatelessWidget {
  const ProfileTabListTitle({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.onPressed,
  });

  final String title;
  final IconData leadingIcon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(
        leadingIcon,
        size: 30,
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      trailing: const Icon(
        Icons.navigate_next,
        size: 30,
      ),
    );
  }
}
