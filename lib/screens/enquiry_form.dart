import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/models/product_enquiry.dart';
import 'package:ocean_blue/screens/homepage.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/customappbar.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_blue/widgets/customdialog.dart';

class EnquiryForm extends StatefulWidget {
  final String productID;
  final String productName;

  const EnquiryForm(
      {super.key, required this.productID, required this.productName});

  @override
  State<EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  final _storage = GetStorage();

  bool loading = false;
  final TextEditingController _productnamecontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _messagecontroller = TextEditingController();

  void submitform() async {
    setState(() {
      loading = true;
    });
    final token = await _storage.read("token");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(submitProductEnquiry));
    request.body = json.encode({
      "productID": widget.productID,
      "fullname": _namecontroller.text,
      "email": _emailcontroller.text,
      "phoneno": _phonecontroller.text,
      "message": _messagecontroller.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var data = ProductEnquiryResponse.fromJson(jsonDecode(json));
      Get.dialog(CustomDialog(
        title: data.message,
        message: "",
        buttonText: "Okay",
        method: () => Get.to(
          () => const HomePage(),
        ),
      ));
      setState(() {
        loading = false;
      });
    } else {
      Get.snackbar("Error", response.reasonPhrase!);
    }
  }

  @override
  void initState() {
    super.initState();
    _productnamecontroller.text = widget.productName;
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
        title: const CustomAppBar(title: "Enquiry Form"),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarCustom(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Product Name",
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
                controller: _productnamecontroller,
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
                  disabledBorder: OutlineInputBorder(
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
                keyboardType: TextInputType.name,
                controller: _namecontroller,
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
                keyboardType: TextInputType.emailAddress,
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
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Phone number",
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
                keyboardType: TextInputType.phone,
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
                    "Message",
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
                keyboardType: TextInputType.multiline,
                controller: _messagecontroller,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                minLines: 5,
                maxLines: 6,
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
                  hintText: "Enter your message",
                  hintStyle: GoogleFonts.montserrat(
                    color: Colors.black38,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: loading ? () {} : submitform,
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
                            "Submit",
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
        ),
      ),
    );
  }
}
