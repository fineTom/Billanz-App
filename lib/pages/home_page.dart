// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls

import 'package:expences_tracker/libary.dart';
import 'package:expences_tracker/model/expence_item.dart';
import 'package:expences_tracker/pages/new_expence.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:expences_tracker/widgets/titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const sidePadding = 30.0;

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DARK_BLUE,
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).push((MaterialPageRoute(
      //               builder: (context) => const NewExpencePage()))),
      //   backgroundColor: BLUE,
      //   splashColor: BLUE,
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: SvgPicture.asset(
      //       "assets/ico/plus.svg",
      //       color: DARK_BLUE,
      //     ),
      //   ),
      // ),
      // drawer: const SideBar(),
      body: ValueListenableBuilder<Box<ExpenceItem>>(
        valueListenable: Boxes.getExpences().listenable(),
        builder: (context, box, _) {
          final expences = box.values.toList().cast<ExpenceItem>();

          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SecondTitle(title: "Current balance"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: sidePadding),
                  child: Row(
                    children: [
                      Text(
                        "\$ ${calculateBilance(expences)}",
                        style: const TextStyle(
                          color: WHITE,
                          fontSize: 40,
                          letterSpacing: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: sidePadding * 1.4,
                      vertical: sidePadding - sidePadding / 3),
                  child: Column(
                    children: [
                      Container(
                        height: 125,
                        decoration: BoxDecoration(
                          color: BLUE,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: const [
                            BoxShadow(
                                color: BLUE, spreadRadius: 1, blurRadius: 17.5),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(width: 1.5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Income",
                                  style: TextStyle(
                                    color: GREY,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 12.5),
                                Text(
                                  "\$ ${calculateMoney("Income")}",
                                  style: const TextStyle(
                                    color: WHITE,
                                    fontSize: 24,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: 1.5,
                              decoration: BoxDecoration(
                                  color: LIGHT_GREY.withOpacity(0.75),
                                  borderRadius: BorderRadius.circular(1.25)),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Spent",
                                  style: TextStyle(
                                    color: GREY,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 12.5),
                                Text(
                                  "\$ ${calculateMoney("Spent")}",
                                  style: const TextStyle(
                                    color: WHITE,
                                    fontSize: 24,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 1.5),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                if (statsFormat == 3) {
                                  statsFormat = 0;
                                  return;
                                }
                                statsFormat += 1;
                              });
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 7.5),
                              decoration: BoxDecoration(
                                color: BLUE,
                                borderRadius: BorderRadius.circular(90),
                                boxShadow: const [
                                  BoxShadow(
                                    color: BLUE,
                                    blurRadius: 7.5,
                                  ),
                                ],
                              ),
                              child: Text(
                                getSortText(),
                                style: const TextStyle(
                                  color: WHITE,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.05,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: sidePadding, vertical: sidePadding * 0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Expences",
                        style: TextStyle(color: GREY, fontSize: 18),
                      ),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).push(
                            (MaterialPageRoute(
                                builder: (context) => const NewExpencePage()))),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          child: Text(
                            "Add new",
                            style: TextStyle(
                              color: BLUE,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: sidePadding * 1.3, vertical: 10),
                          child: GestureDetector(
                            onLongPress: () {
                              Scaffold.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: BLUE,
                                  duration: Duration(milliseconds: 1500),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Item deletet"),
                                ),
                              );
                              Boxes.getExpences().deleteAt(index);
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: DARK_BLUE_ACCENT,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/ico/${getImage(expences[index].category)}",
                                    color: WHITE,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      expences[index].category,
                                      style: const TextStyle(
                                        color: WHITE,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "${months[expences[index].date.month - 1]}, ${expences[index].date.day}, ${expences[index].date.year}",
                                      style: const TextStyle(
                                          color: GREY, fontSize: 13),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  "${expences[index].amout.toStringAsFixed(2)} \$",
                                  style: const TextStyle(
                                    color: WHITE,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: expences.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String getImage(String categorie) {
    if (categorie == "Clothes") return "shopping-bag.svg";
    if (categorie == "Shopping") return "shopping-cart.svg";
    if (categorie == "Transport") return "train-side.svg";
    if (categorie == "Sport") return "gym.svg";
    if (categorie == "Friends") return "users.svg";

    return "user.svg";
  }

  String getSortText() {
    if (statsFormat == 0) {
      return "Last week";
    }
    if (statsFormat == 1) {
      return "Last month";
    }
    if (statsFormat == 2) {
      return "Last year";
    }
    return "Alltime";
  }

  String calculateMoney(String title) {
    final box = Boxes.getExpences();
    final expences = box.values.toList().cast<ExpenceItem>();

    if (statsFormat == 0) {
      if (title == "Income") {
        return convertDoubleToString(calculateStats(7, 0, expences));
      }

      return convertDoubleToString(calculateStats(7, 1, expences));
    }
    if (statsFormat == 1) {
      if (title == "Income") {
        return convertDoubleToString(calculateStats(31, 0, expences));
      }
      return convertDoubleToString(calculateStats(31, 1, expences));
    }
    if (statsFormat == 2) {
      if (title == "Income") {
        return convertDoubleToString(calculateStats(365, 0, expences));
      }
      return convertDoubleToString(calculateStats(365, 1, expences));
    }
    if (title == "Income") {
      return convertDoubleToString(calculateStats(100000, 0, expences));
    }
    return convertDoubleToString(calculateStats(100000, 1, expences));
  }
}

double calculateStats(int days, int plusMinus, List<ExpenceItem> expences) {
  //? plusMinus = 0 => plus
  //? plusMinus = 1 => minus
  double returnValue = 0;

  if (plusMinus == 0) {
    expences.forEach((item) {
      if (item.date.day >= DateTime.now().weekday - days) {
        if (item.amout > 0) returnValue += item.amout;
      }
    });
  }
  if (plusMinus == 1) {
    expences.forEach((item) {
      if (item.date.day >= DateTime.now().weekday - days) {
        if (item.amout < 0) returnValue += item.amout;
      }
    });
  }

  return returnValue;
}

String calculateBilance(List<ExpenceItem> expences) {
  double bilance = 0;
  expences.forEach((element) {
    bilance += element.amout;
  });
  return convertDoubleToString(bilance);
}
