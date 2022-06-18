// ignore_for_file: file_names, unnecessary_this

import 'package:expences_tracker/libary.dart';
import 'package:expences_tracker/pages/home_page.dart';
import 'package:expences_tracker/pages/new_expence.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20),
      width: size.width * 0.75,
      decoration: BoxDecoration(
        color: BLUE,
        borderRadius: BorderRadius.circular(45),
        boxShadow: [
          BoxShadow(
              color: BLUE.withOpacity(0.75), spreadRadius: 2, blurRadius: 20),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: size.width * 0.3,
              height: size.width * 0.3,
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: WHITE,
                image: DecorationImage(
                  image: AssetImage("assets/img/user.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Tom Vogel",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: WHITE),
          ),
          const SizedBox(height: 40),
          PageCart(
            title: "Home",
            function: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomePage()),
            ),
          ),
          // PageCart(
          //   title: "Profile",
          //   function: () => Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => const ProfilePage()),
          //   ),
          // ),
          const SizedBox(height: 10),
          PageCart(
            title: "Add new",
            function: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewExpencePage()),
            ),
          ),
        ],
      ),
    );
  }
}

class PageCart extends StatelessWidget {
  final String title;
  final void Function() function;
  const PageCart({Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.function,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 7.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: 5000,
        decoration: BoxDecoration(
            color: BLUE.withRed(65), borderRadius: BorderRadius.circular(15)),
        child: Text(
          this.title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
