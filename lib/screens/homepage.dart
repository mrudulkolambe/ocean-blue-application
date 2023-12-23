// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/home_svg.dart';
import 'package:ocean_blue/screens/category.dart';
import 'package:ocean_blue/screens/main_form.dart';
import 'package:ocean_blue/screens/profile.dart';
import 'package:ocean_blue/screens/sps_form.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/homescreen_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  GestureDetector(
                    onTap: () => Get.to(() => const ProfileScreen()),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg",
                      ),
                      radius: 20,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      spreadRadius: -5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1593351415075-3bac9f45c877?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
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
                        action: () => Get.to(() => const MainForm(type: "service",)),
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
                        action: () => Get.to(() => const MainForm(type: "emergency",)),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      HomeScreenTile(
                        icon: resaleSVG,
                        title: "Resale Request",
                        action: () => Get.to(() => const MainForm(type: "scrap",)),
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
