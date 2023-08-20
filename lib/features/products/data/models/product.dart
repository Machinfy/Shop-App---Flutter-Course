class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromAddedProduct(
      {required Product addedProduct, required String idFromServer}) {
    return Product(
        id: idFromServer,
        title: addedProduct.title,
        description: addedProduct.description,
        price: addedProduct.price,
        imageUrl: addedProduct.imageUrl);
  }

  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
        id: id,
        title: json['title'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl
    };
  }
}
