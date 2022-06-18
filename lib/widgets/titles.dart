// ignore_for_file: unnecessary_this, use_key_in_widget_constructors

import 'package:expences_tracker/libary.dart';
import 'package:flutter/material.dart';

class SecondTitle extends StatelessWidget {
  final String title;
  const SecondTitle({required this.title});

  static const sidePadding = 30.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: sidePadding, vertical: sidePadding / 3),
      child: Row(
        children: [
          Text(
            this.title,
            style: const TextStyle(color: GREY, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
