import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/api_routes.dart';
import 'package:ocean_blue/constants/colors.dart';
import 'package:ocean_blue/constants/svg/no_data.dart';
import 'package:ocean_blue/models/gallery.dart';
import 'package:ocean_blue/widgets/bottomnavigationbar.dart';
import 'package:ocean_blue/widgets/customappbar.dart';
import 'package:ocean_blue/widgets/gallery_cards.dart';
import 'package:ocean_blue/widgets/gallery_cards_video.dart';
import 'package:ocean_blue/widgets/shimmer/gallery_cards.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool _loading = true;
  List<Gallery> results = [];
  List<Gallery> filterResults = [];
  String type = "image";

  @override
  void initState() {
    super.initState();
    handlePreFetch();
  }

  void handlePreFetch() async {
    var response = await http.get(Uri.parse(gallery));
    if (response.statusCode == 200) {
      var data = GalleryResponse.fromJson(jsonDecode(response.body));
      setState(() {
        results = data.gallery;
        filterResults =
            data.gallery.where((element) => element.type == type).toList();
        _loading = false;
      });
    }
  }

  void handleFilter(String datatype) {
    setState(() {
      filterResults = results.where((element) => element.type == datatype).toList();
      type = datatype;
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
        title: const CustomAppBar(title: "Gallery"),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarCustom(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          handleFilter("image");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: type == "image" ? blue : Colors.white,
                            border: Border.all(
                              width: 2,
                              color: blue,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 40,
                          child: Center(
                            child: Text(
                              "Images",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: type != "image" ? blue : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          handleFilter("video");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: type == "video" ? blue : Colors.white,
                            border: Border.all(
                              width: 2,
                              color: blue,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 40,
                          child: Center(
                            child: Text(
                              "Videos",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: type != "video" ? blue : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              results.isEmpty && !_loading
                  ? SizedBox(
                      height:
                          MediaQuery.of(context).size.height - 120 - 60 - 40,
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.string(noDataFound),
                    )
                  : SizedBox(
                      height:
                          MediaQuery.of(context).size.height - 120 - 60 - 40,
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
                                  childAspectRatio: 4 / 5,
                                  crossAxisSpacing: 15.0,
                                  mainAxisSpacing: 18.0,
                                ),
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return const GalleryCardShimmer();
                                },
                              ),
                            )
                          : GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 4 / 5,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 18.0,
                              ),
                              itemCount: _loading ? 10 : filterResults.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (filterResults[index].type == "image") {
                                  return GalleryCard(
                                    data: filterResults[index],
                                  );
                                } else {
                                  return GalleryCardVideo(
                                      data: filterResults[index]);
                                }
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
