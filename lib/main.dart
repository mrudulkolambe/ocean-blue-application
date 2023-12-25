import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/home_svg.dart';
import 'package:ocean_blue/controller/order.dart';
import 'package:ocean_blue/controller/vendor.dart';
import 'package:ocean_blue/models/Auth.dart';
import 'package:ocean_blue/models/main.dart';
import 'package:ocean_blue/screens/auth/login.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_blue/screens/homepage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ocean Blue',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = GetStorage();
  VendorController vendorController = Get.put(VendorController());
  OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      _isAuthed();
    });
    super.initState();
  }

  Future<void> _isAuthed() async {
    final token = await _storage.read("token");
    if (token.toString() == "" || token == null) {
      Get.to(() => const LoginScreen());
    } else {
      final response = await http.get(Uri.parse(vendorProfileGet),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = ProfileResponse.fromJson(jsonDecode(response.body));
        vendorController.updateVendor(data.response);
        Get.to(() => const HomePage());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.string(logo),
          ],
        ),
      ),
    );
  }
}
