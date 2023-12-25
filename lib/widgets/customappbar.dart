import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/controller/vendor.dart';
import 'package:ocean_blue/screens/profile.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                title,
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GetBuilder<VendorController>(
              init: VendorController(),
              builder: (controller) {
                return GestureDetector(
                  onTap: () => Get.to(const ProfileScreen()),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      controller.vendor.image,
                    ),
                    radius: 20,
                  ),
                );
              })
        ],
      ),
    );
  }
}
