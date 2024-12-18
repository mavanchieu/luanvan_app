import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trẻ em",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 30,
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              color: const Color.fromARGB(255, 210, 210, 210),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/icons/kid/short.png'),
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Quần',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/icons/kid/t-shirt.png'),
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Áo',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              color: const Color.fromARGB(255, 210, 210, 210),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/icons/kid/shoe.png'),
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Giày',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromARGB(255, 210, 210, 210),
                  ),
                ),
              ),
              height: 100,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/icons/kid/sandal.png'),
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Dép',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
