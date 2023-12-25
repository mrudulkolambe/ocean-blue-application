// ignore_for_file: file_names

class AuthResponse {
  bool error;
  String message;
  String response;

  AuthResponse({
    required this.error,
    required this.message,
    required this.response,
  });

  factory AuthResponse.fromJson(dynamic json) {
    final error = json['error'] as bool;
    final message = json['message'] as String;
    final response = json['response'] as String;
    return AuthResponse(
      error: error,
      message: message,
      response: response,
    );
  }
}

class SignupResponse {
  bool error;
  String message;

  SignupResponse({
    required this.error,
    required this.message,
  });

  factory SignupResponse.fromJson(dynamic json) {
    final error = json['error'] as bool;
    final message = json['message'] as String;
    return SignupResponse(
      error: error,
      message: message,
    );
  }
}

class ProfileResponse {
  bool error;
  String message;
  Vendor response;

  ProfileResponse({
    required this.error,
    required this.message,
    required this.response,
  });

  factory ProfileResponse.fromJson(dynamic json) {
    final error = json['error'] as bool;
    final message = json['message'] as String;
    final response = Vendor.fromJson(json['response']);
    return ProfileResponse(
      error: error,
      message: message,
      response: response,
    );
  }
}

class Vendor {
  String id;
  String fullname;
  String companyName;
  String email;
  String phoneNo;
  String image;
  String role;
  bool isVerified;
  int timeStamp;

  Vendor({
    required this.id,
    required this.fullname,
    required this.companyName,
    required this.email,
    required this.phoneNo,
    required this.role,
    required this.isVerified,
    required this.timeStamp,
    required this.image,
  });

  factory Vendor.fromJson(dynamic json) {
    final id = json['_id'] as String;
    final fullname = json['fullname'] as String;
    final companyName = json['companyName'] as String;
    final email = json['email'] as String;
    final phoneNo = json['phoneNo'] as String;
    final isVerified = json['isVerified'] as bool;
    final timeStamp = json['time_stamp'] as int;
    final role = json['role'] as String;
    final image = json['image'] as String;

    return Vendor(
      id: id,
      fullname: fullname,
      companyName: companyName,
      email: email,
      phoneNo: phoneNo,
      isVerified: isVerified,
      timeStamp: timeStamp,
      role: role,
      image: image,
    );
  }
}
