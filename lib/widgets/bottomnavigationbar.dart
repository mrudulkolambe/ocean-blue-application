import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ocean_blue/screens/homepage.dart';
import 'package:ocean_blue/screens/profile.dart';

class NavigationBarCustom extends StatelessWidget {
  const NavigationBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20.0,
          ),
        ],
        border: const Border(
          top: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () => Get.to(() => const HomePage()),
              child: SvgPicture.string(
                '<svg width="33" height="33" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12.591 28.56v-4.216a1.96 1.96 0 0 1 1.958-1.951h3.968c1.089 0 1.971.873 1.971 1.95v4.23c0 .911.734 1.656 1.654 1.677h2.645c2.637 0 4.776-2.116 4.776-4.727V13.527a3.354 3.354 0 0 0-1.323-2.62l-9.048-7.215a4.373 4.373 0 0 0-5.424 0L4.76 10.921a3.328 3.328 0 0 0-1.322 2.62v11.982c0 2.61 2.137 4.727 4.775 4.727h2.645c.943 0 1.707-.756 1.707-1.69" stroke="#0064FF" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>',
                height: 30,
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(() => const ProfileScreen()),
              child: SvgPicture.string(
                '<svg width="33" height="33" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17.188 14.313a5.04 5.04 0 0 1-5.032-5.032 5.04 5.04 0 0 1 5.031-5.031 5.04 5.04 0 0 1 5.032 5.031 5.04 5.04 0 0 1-5.032 5.031Zm2.902 5.902c4.756 0 8.634 3.861 8.66 8.611H5.625c.026-4.75 3.902-8.61 8.66-8.61h5.805Z" stroke="#0064FF" stroke-width="3"/></svg>',
                height: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
