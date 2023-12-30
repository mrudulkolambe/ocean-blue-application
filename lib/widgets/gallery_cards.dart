import 'package:flutter/material.dart';
import 'package:ocean_blue/models/gallery.dart';
import 'package:shimmer/shimmer.dart';

class GalleryCard extends StatelessWidget {
  final Gallery data;

  const GalleryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data.url,
                height: 185,
                fit: BoxFit.cover,
                frameBuilder: (BuildContext context, Widget child, int? frame,
                    bool? wasSynchronouslyLoaded) {
                  return child;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.black26,
                    child: Container(
                      color: Colors.white,
                      height: 185,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
