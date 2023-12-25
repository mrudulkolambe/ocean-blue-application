class AllCategoryResponse {
  bool error;
  String message;
  List<Category> category;

  AllCategoryResponse({
    required this.error,
    required this.message,
    required this.category,
  });

  factory AllCategoryResponse.fromJson(dynamic json) {
    final error = json['error'] as bool;
    final message = json['message'] as String;
    return AllCategoryResponse(
        error: error,
        message: message,
        category: List.from(json["category"]).map((e) {
          return Category.fromJson(e);
        }).toList());
  }
}

class Category {
  String id;
  String name;
  String image;
  String brand;
  int timestamp;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.brand,
    required this.timestamp,
  });

  factory Category.fromJson(dynamic json) {
    final id = json['_id'] as String;
    final name = json['name'] as String;
    final image = json['image'] as String;
    final brand = json['brand'] as String;
    final timestamp = json['timestamp'] as int;
    return Category(
      id: id,
      name: name,
      image: image,
      brand: brand,
      timestamp: timestamp,
    );
  }
}
