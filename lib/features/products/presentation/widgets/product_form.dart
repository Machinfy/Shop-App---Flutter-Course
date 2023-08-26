import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/products/data/models/product.dart';
import 'package:shop_app/features/products/logic/cubit/products_cubit.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key, required this.updatedProductId});

  final String? updatedProductId;
  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _priceFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _managedProduct = Product.empty();

  @override
  void initState() {
    super.initState();
    if (widget.updatedProductId != null) {
      final updatedProduct = context
          .read<ProductsCubit>()
          .findProductById(widget.updatedProductId!);
      _managedProduct = updatedProduct;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.updatedProductId == null) {
        context
            .read<ProductsCubit>()
            .addNewProduct(addedProduct: _managedProduct);
      } else {
        context
            .read<ProductsCubit>()
            .updateProduct(updatedProduct: _managedProduct);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductManaged) {
          Navigator.of(context).pop();
        }
        if (state is ProductFailedToBeManaged) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failureMsg),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _managedProduct.title,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'You Should Enter The Title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _managedProduct =
                            _managedProduct.copyWith(title: value!.trim());
                      },
                      onTapOutside: (_) =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocusNode),
                      decoration: const InputDecoration(
                          hintText: 'Product Name',
                          border: OutlineInputBorder(),
                          label: Text('Title')),
                    ),
                    const Divider(),
                    TextFormField(
                      initialValue: widget.updatedProductId == null
                          ? null
                          : _managedProduct.price.toString(),
                      //initialValue: '${_managedProduct.price}'),

                      focusNode: _priceFocusNode,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'You Should Enter The price!!';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please Enter a Valid Number!!';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please Enter a Number Greater Than Zero!!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _managedProduct = _managedProduct.copyWith(
                            price: double.parse(value!));
                      },
                      onTapOutside: (_) =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          hintText: '10.99',
                          border: OutlineInputBorder(),
                          label: Text('Price')),
                    ),
                    const Divider(),
                    TextFormField(
                      initialValue: _managedProduct.description,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'You Should Enter The Description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _managedProduct =
                            _managedProduct.copyWith(description: value!);
                      },
                      maxLines: 3,
                      onTapOutside: (_) =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      decoration: const InputDecoration(
                          hintText: 'Product Description',
                          border: OutlineInputBorder(),
                          label: Text('Description')),
                    ),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: const Text('Image URL'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue: _managedProduct.imageUrl,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'You Should Enter Image URL!';
                              }
                              if (!value.startsWith('http')) {
                                return 'Please Enter a valid URL!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _managedProduct =
                                  _managedProduct.copyWith(imageUrl: value!);
                            },
                            onTapOutside: (_) => FocusScope.of(context)
                                .requestFocus(FocusNode()),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submitForm(),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Image URL')),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductManagingLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              return ElevatedButton(
                onPressed: _submitForm,
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(220, 45)),
                child: Text(widget.updatedProductId == null ? 'Add' : 'Update'),
              );
            },
          )
        ],
      ),
    );
  }
}
