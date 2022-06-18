// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:expences_tracker/libary.dart';
import 'package:expences_tracker/model/expence_item.dart';
import 'package:expences_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewExpencePage extends StatefulWidget {
  const NewExpencePage({Key? key}) : super(key: key);

  @override
  State<NewExpencePage> createState() => _NewExpencePageState();
}

class _NewExpencePageState extends State<NewExpencePage> {
  String expence = "";
  bool canSetComma = true;
  String? category;
  bool plus = false;

  TextStyle dropDownTextStyle =
      const TextStyle(color: WHITE, fontWeight: FontWeight.bold);

  TextStyle plusMinusTextStyle = const TextStyle(
    color: WHITE,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
  );

  @override
  Widget build(BuildContext context) {
    int numbers = expence.replaceAll(",", "").replaceAll(".", "").length;
    Size size = MediaQuery.of(context).size;
    double widgetWidth = size.width * 0.75;

    return Scaffold(
      backgroundColor: DARK_BLUE,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                      (MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      )),
                    ),
                    icon: SvgPicture.asset(
                      "assets/ico/angle-left.svg",
                      width: 30,
                      height: 30,
                      color: WHITE,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: widgetWidth,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: DARK_BLUE_ACCENT,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$expence \$",
                style: const TextStyle(fontSize: 30, color: WHITE),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 7.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: DARK_BLUE_ACCENT,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin:
                      EdgeInsets.only(right: (size.width - widgetWidth) / 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            plus = true;
                          }),
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 2.5,
                              top: 5,
                              bottom: 5,
                            ),
                            child: Container(
                              child: Text(
                                "+",
                                style: plusMinusTextStyle.copyWith(
                                    color: plus ? GREEN : WHITE),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7.5),
                        GestureDetector(
                          onTap: () => setState(() {
                            plus = false;
                          }),
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                              left: 2.5,
                              top: 5,
                              bottom: 5,
                            ),
                            child: Container(
                              child: Text(
                                "-",
                                style: plusMinusTextStyle.copyWith(
                                    color: plus ? WHITE : GREEN),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: widgetWidth,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
              decoration: BoxDecoration(
                color: DARK_BLUE_ACCENT,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  category == null ? "Choose your category..." : category!,
                  style: dropDownTextStyle,
                ),
                borderRadius: BorderRadius.circular(10),
                dropdownColor: DARK_BLUE_ACCENT,
                underline: const SizedBox(),
                menuMaxHeight: 200,
                items: categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style: dropDownTextStyle,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (item) => setState(
                  () {
                    category = item.toString();
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: DARK_BLUE_ACCENT),
              onPressed: () {
                final box = Boxes.getExpences();
                box.add(
                  ExpenceItem(
                    category == null ? "Shopping" : category!,
                    DateTime.now(),
                    double.parse(
                      (plus
                          ? expence.replaceAll(".", "").replaceAll(",", ".")
                          : "-${expence.replaceAll(".", "").replaceAll(",", ".")}"),
                    ),
                  ),
                );
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: SizedBox(
                width: widgetWidth - 30,
                height: 55,
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(width: size.width, height: 1, color: DARK_BLUE_ACCENT),
            Container(
              height: size.height * 0.35,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 2),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 9) {
                    return NumBlockItem(
                      title: "•",
                      function: () => setState(
                        () {
                          if (canSetComma || expence.isNotEmpty) {
                            canSetComma = false;
                            expence.substring(
                                        expence.length - 1, expence.length) ==
                                    ","
                                ? expence
                                : expence += ",";
                          }
                        },
                      ),
                    );
                  }
                  if (index == 10) {
                    return NumBlockItem(
                      title: "0",
                      function: () => setState(() {
                        expence += "0";
                      }),
                    );
                  }
                  if (index == 11) {
                    return NumBlockItem(
                      title: "",
                      function: () => setState(() {
                        expence != ""
                            ? expence = expence.substring(0, expence.length - 1)
                            : expence;
                      }),
                      icon: true,
                    );
                  }
                  return NumBlockItem(
                    title: (index + 1).toString(),
                    function: () => setState(() {
                      if (setPoint(numbers)) {
                        expence += ".";
                      }
                      expence += (index + 1).toString();
                    }),
                  );
                },
                itemCount: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool setPoint(numbers) {
    if (canSetComma == false) return false;
    if (numbers % 3 == 0) {
      return numbers != 0 ? true : false;
    }
    return false;
  }
}

class NumBlockItem extends StatefulWidget {
  final String title;
  final void Function() function;
  final bool? icon;
  const NumBlockItem({required this.title, required this.function, this.icon});

  @override
  State<NumBlockItem> createState() => _NumBlockItemState();
}

class _NumBlockItemState extends State<NumBlockItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: this.widget.function,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.01, vertical: size.width * 0.005),
        child: Center(
          child: this.widget.icon == null
              ? Text(
                  this.widget.title,
                  style: TextStyle(
                      color: WHITE,
                      fontSize: this.widget.title == "•" ? 50 : 25,
                      fontWeight: FontWeight.w500),
                )
              : SvgPicture.asset(
                  "assets/ico/delete.svg",
                  color: WHITE,
                ),
        ),
      ),
    );
  }
}
