// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/home_svg.dart';
import 'package:ocean_blue/controller/order.dart';
import 'package:ocean_blue/controller/vendor.dart';
import 'package:ocean_blue/models/orders.dart';
import 'package:ocean_blue/screens/category.dart';
import 'package:ocean_blue/screens/main_form.dart';
import 'package:ocean_blue/screens/profile.dart';
import 'package:ocean_blue/screens/sps_form.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/homescreen_tiles.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OrderController orderController = Get.put(OrderController());
  final _storage = GetStorage();
  late Timer _timer;

  void handlePreFetch() async {
    final token = await _storage.read("token");
    var orderResponse = await http.get(Uri.parse(getOrderByVendor),
        headers: {"Authorization": "Bearer $token"});
    if (orderResponse.statusCode == 200) {
      var pastOrders = OrderResponse.fromJson(jsonDecode(orderResponse.body));
      orderController.updateOrders(pastOrders.response);
    }
  }

  @override
  void initState() {
    super.initState();
    handlePreFetch();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      handlePreFetch();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarCustom(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/logo.png",
                    height: 40,
                  ),
                  GetBuilder<VendorController>(
                      init: VendorController(),
                      builder: (vendorcontroller) {
                        return GestureDetector(
                          onTap: () => Get.to(() => const ProfileScreen()),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              vendorcontroller.vendor.image,
                            ),
                            radius: 20,
                          ),
                        );
                      })
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      spreadRadius: -5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/launch.jpg",
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    frameBuilder: (BuildContext context, Widget child,
                        int? frame, bool? wasSynchronouslyLoaded) {
                      return child;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Dashboard",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      HomeScreenTile(
                        icon: productListSVG,
                        title: "Product List",
                        action: () => Get.to(() => const CategoryScreen()),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      HomeScreenTile(
                        icon: bookServiceSVG,
                        title: "Book a Service",
                        action: () => Get.to(() => const MainForm(
                              type: "service",
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      HomeScreenTile(
                        icon: emergencySVG,
                        title: "Emergency",
                        action: () => Get.to(() => const MainForm(
                              type: "emergency",
                            )),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      HomeScreenTile(
                        icon: resaleSVG,
                        title: "Resale Request",
                        action: () => Get.to(() => const MainForm(
                              type: "scrap",
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      HomeScreenTile(
                        icon: spsSVG,
                        title: "Become SPS",
                        action: () => Get.to(() => const SPSForm()),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      HomeScreenTile(
                        icon: profileSVG,
                        title: "Profile",
                        action: () => Get.to(() => const ProfileScreen()),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
