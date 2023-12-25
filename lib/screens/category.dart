import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/constants/svg/no_data.dart';
import 'package:ocean_blue/models/category.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/category_card.dart';
import 'package:ocean_blue/widgets/customappbar.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_blue/widgets/shimmer/category_card.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> categories = [];
  List<Category> searchResults = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    handlePreFetch();
  }

  void handleSearch(String value) {
    var searchData = categories.where(
        (element) => element.name.toLowerCase().contains(value.toLowerCase()));
    setState(() {
      searchResults = searchData.toList();
    });
  }

  void handlePreFetch() async {
    try {
      var response = await http.get(Uri.parse(getAllCategories));
      var data = AllCategoryResponse.fromJson(jsonDecode(response.body));
      setState(() {
        _loading = false;
        categories = data.category;
        searchResults = data.category;
      });
    } catch (e) {
      // print(e);
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
        title: const CustomAppBar(title: "Category"),
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
                height: 20,
              ),
            searchResults.isEmpty ?  SizedBox(
                height: MediaQuery.of(context).size.height - 120 - 100 - 10,
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.string(noDataFound)
              ) : 
              SizedBox(
                height: MediaQuery.of(context).size.height - 120 - 100 - 10,
                width: MediaQuery.of(context).size.width,
                child: _loading
                    ? Shimmer.fromColors(
                        period: const Duration(seconds: 2),
                        baseColor: Colors.grey.withOpacity(0.2),
                        highlightColor: Colors.grey.withOpacity(0.4),
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4 / 4.5,
                            crossAxisSpacing: 18.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return const CategoryCardShimmer();
                          },
                        ),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 4 / 4.5,
                          crossAxisSpacing: 18.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: _loading ? 10 : searchResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryCard(
                            category: searchResults[index],
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
