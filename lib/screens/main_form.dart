import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/constants/svg/no_data.dart';
import 'package:ocean_blue/controller/order.dart';
import 'package:ocean_blue/models/orders.dart';
import 'package:ocean_blue/screens/homepage.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/customappbar.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_blue/widgets/customdialog.dart';

class MainForm extends StatefulWidget {
  final String type;

  const MainForm({super.key, required this.type});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  final _storage = GetStorage();
  OrderController orderController = Get.put(OrderController());
  List<Orders> orders = [];
  bool loading = false;
  bool isPresent = false;
  String orderID = "";
  final TextEditingController _modeltypecontroller = TextEditingController();
  final TextEditingController _messagecontroller = TextEditingController();

  void submitForm() async {
    if (orderID.isEmpty) {
      setState(() {
        orderID = orderController.orders.first.id;
      });
    }
    final token = await _storage.read("token");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
          widget.type == "service"
              ? createServiceApi
              : widget.type == "emergency"
                  ? createEmergencyApi
                  : createScrapApi,
        ));
    request.body =
        json.encode({"orderID": orderID, "message": _messagecontroller.text});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Future.delayed(const Duration(seconds: 2));
      Get.dialog(CustomDialog(
        title: widget.type == "service"
            ? "Service Booked Successfully"
            : widget.type == "emergency"
                ? "Emergency Requested Successfully"
                : "Scrap Request Successful",
        message: "",
        method: () => Get.to(() => const HomePage()),
        buttonText: "Close",
      ));
    } else {
      Get.snackbar("Error", response.reasonPhrase!);
    }
  }

  @override
  void initState() {
    super.initState();
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
        title: CustomAppBar(
          title: widget.type == "service"
              ? "Book a Service"
              : widget.type == "emergency"
                  ? "Emergency Request"
                  : "Scrap Request",
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarCustom(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<OrderController>(
              init: OrderController(),
              builder: (ordercontroller) {
                if (orderController.orders.isNotEmpty) {
                  _modeltypecontroller.text =
                      ordercontroller.orders.first.productId.category.name;
                }
                return ordercontroller.orders.isEmpty
                    ? Center(
                        child: SvgPicture.string(noDataFound),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Product name",
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
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: lightgray,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DropdownButton(
                                isExpanded: true,
                                value: orderID.isEmpty
                                    ? ordercontroller.orders.first.id
                                    : orderID,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                hint: Text(
                                  "Select Order",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black38,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    orderID = value!;
                                    _modeltypecontroller.text =
                                        ordercontroller.orders
                                            .where((element) =>
                                                element.id == value)
                                            .toList()
                                            .first
                                            .productId
                                            .category
                                            .name;
                                  });
                                },
                                items: ordercontroller.orders
                                    .map(
                                      (Orders value) => DropdownMenuItem(
                                        value: value.id,
                                        child: Text(
                                          value.productId.name,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                iconSize: 0,
                                underline: const SizedBox(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Model type",
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
                            controller: _modeltypecontroller,
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
                              hintText: "Enter model type",
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
                            onTap: loading ? () {} : submitForm,
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
                                        color: Colors.white,
                                        size: 20,
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
                      );
              }),
        ),
      ),
    );
  }
}
