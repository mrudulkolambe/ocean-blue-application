import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/models/Auth.dart';
import 'package:ocean_blue/models/main.dart';
import 'package:ocean_blue/screens/auth/login.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_blue/screens/homepage.dart';

class VendorController extends GetxController {
  final _storage = GetStorage();
  Vendor vendor = Vendor(
      fullname: "",
      id: "",
      companyName: "",
      email: "",
      isVerified: false,
      phoneNo: "",
      timeStamp: 0,
      role: "vendor",
      image: "");

  void updateVendor(Vendor data) {
    vendor = data;
    update();
  }

  void isAuthed(bool routed) async {
    final token = await _storage.read("token");
    if (token.toString() == "" || token == null) {
      Get.to(() => const LoginScreen());
    } else {
      final response = await http.get(Uri.parse(vendorProfileGet),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = ProfileResponse.fromJson(jsonDecode(response.body));
        updateVendor(data.response);
        if(routed) Get.to(() => const HomePage());
      } else {
        var data = ErrorResponse.fromJson(jsonDecode(response.body));
        GetSnackBar(
          title: "Error",
          message: data.message,
        );
        Get.to(() => const LoginScreen());
      }
    }
  }
}
