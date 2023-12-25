class ProductEnquiryResponse {
  bool error;
  String message;
  Enquiry response;

  ProductEnquiryResponse({
    required this.error,
    required this.message,
    required this.response,
  });

  factory ProductEnquiryResponse.fromJson(dynamic json) {
    final error = json['error'] as bool;
    final message = json['message'] as String;
    final enquiry = Enquiry.fromJson(json['response']);

    return ProductEnquiryResponse(
      error: error,
      message: message,
      response: enquiry,
    );
  }
}

class Enquiry {
  String productId;
  String vendorId;
  String fullname;
  String email;
  String phoneno;
  String message;
  int timestamp;
  bool completed;
  String id;

  Enquiry({
    required this.productId,
    required this.vendorId,
    required this.fullname,
    required this.email,
    required this.phoneno,
    required this.message,
    required this.timestamp,
    required this.completed,
    required this.id,
  });

  factory Enquiry.fromJson(dynamic json) {
    final productID = json["productID"] as String;
    final vendorID = json["vendorID"] as String;
    final fullname = json["fullname"] as String;
    final email = json["email"] as String;
    final phoneno = json["phoneno"] as String;
    final message = json["message"] as String;
    final timestamp = json["timestamp"] as int;
    final completed = json["completed"] as bool;
    final id = json["_id"] as String;

    return Enquiry(
      productId: productID,
      vendorId: vendorID,
      fullname: fullname,
      email: email,
      phoneno: phoneno,
      message: message,
      timestamp: timestamp,
      completed: completed,
      id: id,
    );
  }
}
