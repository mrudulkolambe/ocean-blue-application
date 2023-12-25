import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/screens/homepage.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/customappbar.dart';
import 'package:ocean_blue/widgets/customdialog.dart';
import 'package:http/http.dart' as http;

class SPSForm extends StatefulWidget {
  const SPSForm({super.key});

  @override
  State<SPSForm> createState() => _SPSFormState();
}

class _SPSFormState extends State<SPSForm> {
  bool _isChecked = false;
  final TextEditingController _messagecontroller = TextEditingController();
  final _storage = GetStorage();

  void submitForm() async {
    final token = await _storage.read("token");
    if (_isChecked) {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(createSPS));
      request.body = json.encode({"message": _messagecontroller.text});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Get.dialog(
          CustomDialog(
            title: 'SPS submitted successfully',
            message: "",
            buttonText: "Okay",
            method: () => Get.to(() => const HomePage()),
          ),
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
        );
      } else {
        Get.snackbar("Error", response.reasonPhrase!);
      }
    } else {
      Get.snackbar("Error", "Please agree the terms and conditions");
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
        title: const CustomAppBar(title: "Become SPS"),
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
                minLines: 7,
                maxLines: 7,
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
                height: 10,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: blue.withOpacity(0.6),
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    "I agree the terms and conditions",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: submitForm,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
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
