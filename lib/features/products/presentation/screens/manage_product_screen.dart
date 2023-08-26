import 'package:flutter/material.dart';

import '../widgets/product_form.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({super.key});

  static const routeName = '/manage-product';
  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final updatedProductId = routeData?['updatedProductId'] as String?;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            updatedProductId == null ? 'Add New Product' : 'Update Product'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ProductForm(
            updatedProductId: updatedProductId,
          ),
        ),
      ),
    );
  }
}
