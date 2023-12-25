import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/constants/svg/no_data.dart';
import 'package:ocean_blue/models/product.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/customappbar.dart';
import 'package:ocean_blue/widgets/product_card.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_blue/widgets/shimmer/product_card.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  final String category;

  const ProductList({super.key, required this.category});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];
  List<Product> searchResults = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    handlePreFetch();
  }

  void handleSearch(String value) {
    var searchData = products.where(
        (element) => element.name.toLowerCase().contains(value.toLowerCase()));
    setState(() {
      searchResults = searchData.toList();
    });
  }

  void handlePreFetch() async {
    var response =
        await http.get(Uri.parse("$getProductsByCategory/${widget.category}"));
    if (response.statusCode == 200) {
      var data = ProductResponse.fromJson(jsonDecode(response.body));
      setState(() {
        loading = false;
        products = data.product;
        searchResults = data.product;
      });
    } else {}
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
        title: const CustomAppBar(title: "Buy a Product"),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarCustom(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                onChanged: handleSearch,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: blue,
                  ),
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
                  hintText: "Search...",
                  hintStyle: GoogleFonts.montserrat(
                    color: Colors.black38,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              searchResults.isEmpty && !loading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 120 - 100,
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.string(noDataFound))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 120 - 100,
                      width: MediaQuery.of(context).size.width,
                      child: loading
                          ? Shimmer.fromColors(
                              period: const Duration(seconds: 2),
                              baseColor: Colors.grey.withOpacity(0.2),
                              highlightColor: Colors.grey.withOpacity(0.4),
                              child: ListView.builder(
                                itemCount: 10,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return const ProductCardShimmer();
                                },
                              ),
                            )
                          : ListView.builder(
                              itemCount: searchResults.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return ProductCard(
                                  product: searchResults[index],
                                );
                              }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
