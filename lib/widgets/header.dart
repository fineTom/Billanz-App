// ignore_for_file: use_key_in_widget_constructors, unnecessary_this

import 'package:expences_tracker/libary.dart';
import 'package:expences_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final bool? goBack;
  const Header({this.goBack});

  static const sidePadding = 30.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: sidePadding, vertical: sidePadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          this.goBack == null
              ? HeaderItem(
                  imageURL: "assets/ico/hamburger.svg",
                  function: () {
                    Scaffold.of(context).openDrawer();
                  })
              : HeaderItem(
                  imageURL: "assets/ico/angle-left.svg",
                  function: () => Navigator.of(context).push(
                    (MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    )),
                  ),
                ),
          // HeaderItem(
          //     imageURL: "assets/ico/user.svg",
          //     function: () {
          //       Navigator.of(context).push((MaterialPageRoute(
          //           builder: (context) => const ProfilePage())));
          //     })
        ],
      ),
    );
  }
}

class HeaderItem extends StatelessWidget {
  final String imageURL;
  final void Function() function;
  const HeaderItem({required this.imageURL, required this.function});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: function,
      icon: SvgPicture.asset(
        imageURL,
        width: imageURL == "assets/ico/angle-left.svg" ? 30 : 40,
        height: imageURL == "assets/ico/angle-left.svg" ? 30 : 40,
        color: WHITE,
      ),
    );
  }
}
