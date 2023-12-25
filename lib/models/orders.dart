import 'package:ocean_blue/models/product.dart';

class OrderResponse {
  bool error;
  String message;
  List<Orders> response;

  OrderResponse({
    required this.error,
    required this.message,
    required this.response,
  });
  factory OrderResponse.fromJson(dynamic json) {
    final error = json['error'] as bool;
    final message = json['message'] as String;
    final response = List.from(json["response"]).map((e) {
      return Orders.fromJson(e);
    }).toList();

    return OrderResponse(
      error: error,
      message: message,
      response: response,
    );
  }
}

class Orders {
  String id;
  Product productId;
  String vendorId;
  String enquiryId;
  int timestamp;
  String status;

  Orders({
    required this.id,
    required this.productId,
    required this.vendorId,
    required this.enquiryId,
    required this.timestamp,
    required this.status,
  });

  factory Orders.fromJson(dynamic json) {
    final id = json['_id'] as String;
    final product = Product.fromJson(json['productID']);
    final vendorId = json['vendorID'] as String;
    final enquiryId = json['enquiryID'] as String;
    final status = json['status'] as String;
    final timestamp = json['timestamp'] as int;
    return Orders(
      id: id,
      productId: product,
      vendorId: vendorId,
      enquiryId: enquiryId,
      status: status,
      timestamp: timestamp,
    );
  }
}
