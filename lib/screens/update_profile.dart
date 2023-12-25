import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/controller/vendor.dart';
import 'package:ocean_blue/models/Auth.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/customappbar.dart';
import 'package:ocean_blue/widgets/customdialog.dart';
import 'package:http/http.dart' as http;

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _storage = GetStorage();

  final TextEditingController _fullnamecontroller = TextEditingController();
  final TextEditingController _companynamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  VendorController vendorController = Get.put(VendorController());
  bool loading = false;

  @override
  void initState() {
    super.initState();
    handlePreFetch();
  }

  void handlePreFetch() async {
    final token = await _storage.read("token");
    final response = await http.get(Uri.parse(vendorProfileGet),
        headers: {'Authorization': 'Bearer $token'});
    var data = ProfileResponse.fromJson(jsonDecode(response.body));
    vendorController.updateVendor(data.response);
    _fullnamecontroller.text = data.response.fullname;
    _companynamecontroller.text = data.response.companyName;
    _phonecontroller.text = data.response.phoneNo;
    _emailcontroller.text = data.response.email;
  }

  void updateVendorProfile() async {
    final token = await _storage.read("token");
    setState(() {
      loading = true;
    });
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PATCH', Uri.parse(vendorProfileUpdate));
    request.body = json.encode({
      "fullname": _fullnamecontroller.text,
      "companyName": _companynamecontroller.text,
      "email": "mrudul@gmail.com",
      "phoneNo": _phonecontroller.text,
      "image":
          "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var data = ProfileResponse.fromJson(jsonDecode(responseData));
      vendorController.updateVendor(data.response);
      _fullnamecontroller.text = data.response.fullname;
      _phonecontroller.text = data.response.phoneNo;
      _companynamecontroller.text = data.response.companyName;
      Get.dialog(CustomDialog(
        title: "Profile Updated Successfully",
        message: "",
        buttonText: "Okay",
        method: () => Get.back(),
      ));
    } else {
      Get.snackbar("Error", response.reasonPhrase!);
    }
    setState(() {
      loading = false;
    });
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
        title: const CustomAppBar(title: "Update Profile"),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarCustom(),
      body: SafeArea(
        child: GetBuilder<VendorController>(
            init: VendorController(),
            builder: (controller) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            controller.vendor.image,
                          ),
                          radius: 70,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.vendor.fullname,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.vendor.email,
                      style: GoogleFonts.montserrat(
                        color: Colors.black38,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Text(
                          "Full name",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      controller: _fullnamecontroller,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightgray,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        hintText: "Enter your full name",
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black38,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Company name",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      controller: _companynamecontroller,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightgray,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        hintText: "Enter your company name",
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black38,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Phone Number",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      controller: _phonecontroller,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightgray,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        hintText: "Enter your phone number",
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black38,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Email",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: _emailcontroller,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightgray,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        hintText: "Enter your email address",
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black38,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: loading ? () {} : updateVendorProfile,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: loading
                              ? const SpinKitThreeBounce(
                                  size: 20,
                                  color: Colors.white,
                                )
                              : Text(
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
                  ],
                ),
              );
            }),
      ),
    );
  }
}
