class ErrorResponse {
  bool error;
  String message;

  ErrorResponse({
    required this.error,
    required this.message,
  });

  factory ErrorResponse.fromJson(dynamic json) {
    final error = json['error'] as bool;
    final message = json['message'] as String;
    return ErrorResponse(
      error: error,
      message: message,
    );
  }
}
