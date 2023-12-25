import 'package:ocean_blue/models/category.dart';

class ProductResponse {
  bool error;
  String message;
  List<Product> product;

  ProductResponse({
    required this.error,
    required this.message,
    required this.product,
  });

  factory ProductResponse.fromJson(dynamic json) {
    final error = json['error'] as bool;
    final message = json["message"] as String;
    final products = List.from(json["product"]).map((e) {
      return Product.fromJson(e);
    }).toList();
    return ProductResponse(
      error: error,
      message: message,
      product: products,
    );
  }
}

class Product {
  String id;
  String image;
  String name;
  String description;
  String price;
  Category category;
  int timestamp;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.timestamp,
  });

  factory Product.fromJson(dynamic json) {
    final id = json['_id'] as String;
    final image = json['image'] as String;
    final name = json['name'] as String;
    final description = json['description'] as String;
    final price = json['price'] as String;
    final category = Category.fromJson(json['category']);
    final timestamp = json['timestamp'] as int;
    return Product(
      id: id,
      image: image,
      name: name,
      description: description,
      timestamp: timestamp,
      price: price,
      category: category,
    );
  }
}
