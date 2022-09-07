import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<bool> isSelected = [true, false];

  void isSelectedChange() {
    isSelected[0] = !isSelected[0];
    isSelected[1] = !isSelected[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        title: Row(
          children: [
            SizedBox(
              width: 80,
            ),
            Text(
              'Idioma',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => setState(() {
                    isSelectedChange();
                  }),
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: isSelected[0]
                          ? Color.fromARGB(255, 255, 120, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Portugues',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => setState(() {
                    isSelectedChange();
                  }),
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: isSelected[1]
                          ? Color.fromARGB(255, 255, 120, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Ingles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
