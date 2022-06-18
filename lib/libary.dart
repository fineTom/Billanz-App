// ignore_for_file: constant_identifier_names

import 'package:expences_tracker/model/expence_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const DARK_BLUE = Color(0xFF25252A);
const DARK_BLUE_ACCENT = Color.fromARGB(255, 49, 49, 55);
const BLUE = Color(0xFF264EF8);
const GREEN = Color(0xFF0CF574);
const RED = Color(0xFFEF6351);
const WHITE = Color(0xFFFAFFFD);
const GREY = Color(0xFF93939F);
const LIGHT_GREY = Color(0xFFE1E5EE);

// ? Models

// * All
double cash = 150.20;

// // * Weekly
// double weeklyIncome = 20.50;
// double weeklySpent = 14.75;

// * Monthly
double monthlyIncome = 60.54;
double monthlySpent = 34.60;

// * Yearly
double yearlyIcome = 205.50;
double yearlySpent = 140.20;

// * ALl
double allTimeIncome = 530.49;
double allTimeSpent = 230.30;

/*
0 = weekly
1 = monthly
2 = yearly
3 = alltime
*/

int statsFormat = 0;

String convertDoubleToString(double number) {
  String numberString = number.toStringAsFixed(2);
  return numberString.replaceAll(".", ",");
}

// List<ExpenceItem> expenceItems = [
//   ExpenceItem("Shopping", DateTime.now(), -24.50),
//   ExpenceItem("Transport", DateTime.now(), -20.90),
//   ExpenceItem("Friends", DateTime.now(), -10.49),
//   ExpenceItem("Sport", DateTime.now(), -49.00),
// ];

List<String> categories = [
  "Shopping",
  "Food shopping",
  "Friends",
  "Sport",
  "Fiverr",
  "Work",
  "Pocket money",
];

class Boxes {
  static Box<ExpenceItem> getExpences() => Hive.box<ExpenceItem>("expences");
}

// List<ExpenceItem> readItems() {
//   final box = Boxes.getExpences();
//   return box.values.toList().cast<ExpenceItem>();
// }
