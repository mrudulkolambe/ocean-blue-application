import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/models/auth.dart';
import 'package:ocean_blue/screens/auth/login.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_blue/widgets/customdialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _companynamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _fullnamecontroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signup() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(vendorSignUp));
    request.body = json.encode({
      "email": _emailController.text,
      "password": _passwordController.text,
      "companyName": _companynamecontroller.text,
      "phoneNo": _phonecontroller.text,
      "fullname": _fullnamecontroller.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var data = SignupResponse.fromJson(jsonDecode(responseString));
      Get.dialog(CustomDialog(
        title: data.message,
        message: "Contact with admin to approve your account",
        method: () => Get.back(),
        buttonText: "Close",
      ));
    } else {
      Get.snackbar("Error", response.reasonPhrase!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 80,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Register",
                style: GoogleFonts.quicksand(
                  fontSize: 30,
                  color: blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Create your new account",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Full Name",
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
                    "Company Name",
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
                controller: _emailController,
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
                  hintText: "Enter email address",
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
                    "Password",
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
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
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
                  hintText: "Enter password",
                  hintStyle: GoogleFonts.montserrat(
                    color: Colors.black38,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: signup,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Create Account",
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const LoginScreen()),
                    child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blue,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
