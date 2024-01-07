class RequestResponse {
  bool error;
  String message;
  FormResponse response;

  RequestResponse({
    required this.error,
    required this.message,
    required this.response,
  });

  factory RequestResponse.fromJson(dynamic json) {
    final error = json["error"] as bool;
    final message = json["message"] as String;
    final response = FormResponse.fromJson(json["response"]);
    return RequestResponse(error: error, message: message, response: response);
  }
}

class FormResponse {
  String orderId;
  String vendorId;
  int timestamp;
  bool completed;
  String message;
  String id;

  FormResponse({
    required this.orderId,
    required this.vendorId,
    required this.timestamp,
    required this.completed,
    required this.message,
    required this.id,
  });

  factory FormResponse.fromJson(dynamic json) {
    final orderId = json["orderID"] as String;
    final vendorId = json["vendorID"] as String;
    final timestamp = json["timestamp"] as int;
    final completed = json["completed"] as bool;
    final message = json["message"] as String;
    final id = json["_id"] as String;
    return FormResponse(
      orderId: orderId,
      vendorId: vendorId,
      timestamp: timestamp,
      completed: completed,
      message: message,
      id: id,
    );
  }
}

class SpsResponse {
  bool error;
  String message;
  SPS response;

  SpsResponse({
    required this.error,
    required this.message,
    required this.response,
  });
  factory SpsResponse.fromJson(dynamic json) {
    final error = json["error"] as bool;
    final message = json["message"] as String;
    final response = SPS.fromJson(json["response"]);
    return SpsResponse(
      error: error,
      message: message,
      response: response,
    );
  }
}

class SPS {
  String vendorId;
  String message;
  int timestamp;
  bool completed;
  String id;

  SPS({
    required this.vendorId,
    required this.message,
    required this.timestamp,
    required this.completed,
    required this.id,
  });
  factory SPS.fromJson(dynamic json) {
    final vendorId = json["vendorID"] as String;
    final message = json["message"] as String;
    final timestamp = json["timestamp"] as int;
    final completed = json["completed"] as bool;
    final id = json["_id"] as String;
    return SPS(
      vendorId: vendorId,
      message: message,
      timestamp: timestamp,
      completed: completed,
      id: id,
    );
  }
}
