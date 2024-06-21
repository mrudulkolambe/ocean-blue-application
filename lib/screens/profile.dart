import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/controller/vendor.dart';
import 'package:ocean_blue/models/orders.dart';
import 'package:ocean_blue/screens/auth/login.dart';
import 'package:ocean_blue/screens/update_profile.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_blue/widgets/product_card.dart';
import 'package:ocean_blue/widgets/shimmer/product_card.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _storage = GetStorage();
  bool loading = true;
  List<Orders> orders = [];

  @override
  void initState() {
    super.initState();
    handlePreFetch();
  }

  void handlePreFetch() async {
    final token = await _storage.read("token");
    var response = await http.get(Uri.parse(getOrderByVendor),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      var pastOrders = OrderResponse.fromJson(jsonDecode(response.body));
      setState(() {
        loading = false;
        orders = pastOrders.response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Profile",
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    final token = await _storage.read("token");
                    final response =
                        await http.patch(Uri.parse(vendorLogout), headers: {
                      'Authorization': 'Bearer $token',
                    });
                    if (response.statusCode == 200) {
                      await _storage.remove("token");
                      Get.to(() => const LoginScreen());
                    } else {
                      Get.snackbar("Error", "Try again");
                    }
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarCustom(),
      body: SafeArea(
        child: GetBuilder<VendorController>(
            init: VendorController(),
            builder: (vendorController) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 160,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(vendorController.vendor.image),
                            radius: 55,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        vendorController.vendor.fullname,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        vendorController.vendor.email,
                        style: GoogleFonts.montserrat(
                          color: Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const UpdateProfileScreen()),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Update",
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Past Orders",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      !loading && orders.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.47,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  "No Data Found",
                                  style: GoogleFonts.montserrat(),
                                ),
                              ))
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.47,
                              width: MediaQuery.of(context).size.width,
                              child: loading
                                  ? Shimmer.fromColors(
                                      period: const Duration(seconds: 2),
                                      baseColor: Colors.grey.withOpacity(0.2),
                                      highlightColor:
                                          Colors.grey.withOpacity(0.4),
                                      child: ListView.builder(
                                          itemCount: 10,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return const ProductCardShimmer();
                                          }),
                                    )
                                  : ListView.builder(
                                      itemCount: orders.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ProductCard(
                                          product: orders[index].productId,
                                          enquire: false,
                                        );
                                      },
                                    ),
                            ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
