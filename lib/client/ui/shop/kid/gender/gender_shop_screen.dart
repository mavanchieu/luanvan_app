import 'package:app_lv/client/ui/shop/kid/brand/brand_screen.dart';
import 'package:app_lv/client/ui/shop/kid/type/type_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderShopScreen extends StatefulWidget {
  const GenderShopScreen({super.key});

  @override
  State<GenderShopScreen> createState() => _GenderShopScreenState();
}

class _GenderShopScreenState extends State<GenderShopScreen> {
  final List<String> _listBrandsName = [
    'Nike',
    'Adidas',
    // 'Puma',
    'Levents',
    'DirtyCoins',
    // 'Levents',
    // 'DirtyCoins',
  ];

  final List<String> _listName = [
    'Nam',
    'Nữ',
    // 'Puma',
    'Nike',
    'Adidas',
    // 'Phong cách',
    // 'Cá tính',
  ];

  final List<String> _listBrandsImage = [
    'assets/image/shop/kid/adidas_2.png',
    'assets/image/shop/kid/adidas_3.png',
    // 'assets/image/shop/puma.webp',
    'assets/image/shop/kid/nike_2.png',
    'assets/image/shop/kid/adidas_4.png',
    // 'assets/image/shop/kid/nike.png',
    // 'assets/image/shop/kid/adidas.png',
  ];
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
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrandScreen(),
                  ),
                );
              },
              child: Container(
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
                                image: AssetImage(
                                    'assets/icons/kid/children-male.png'),
                                width: 40,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Nam',
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
            ),
            Container(
              height: 100,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/icons/kid/children-female.png'),
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Nữ',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, top: 10, right: 5),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                            color: const Color.fromARGB(255, 154, 154, 154),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                "assets/icons/kid/sale.png",
                              ),
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              "SALE",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        width: 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                            color: const Color.fromARGB(255, 154, 154, 154),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                "assets/icons/kid/top_sell.png",
                              ),
                              width: 60,
                            ),
                            Text(
                              "TOP BÁN CHẠY",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                            color: const Color.fromARGB(255, 154, 154, 154),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                "assets/icons/kid/sport.png",
                              ),
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              "THỂ THAO",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        width: 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                            color: const Color.fromARGB(255, 154, 154, 154),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                "assets/icons/kid/new.png",
                              ),
                              width: 60,
                            ),
                            Text(
                              "SẢN PHẨM MỚI",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
