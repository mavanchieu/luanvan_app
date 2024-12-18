import 'package:app_lv/client/ui/account/body/shop/userDiscountCode_screen.dart';
import 'package:app_lv/client/ui/account/body/shop/search/history_search_screen.dart';
import 'package:app_lv/client/ui/account/body/shop/viewedProduct_screen.dart';
import 'package:app_lv/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Cửa hàng",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 23, 0, 197)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 30,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Lịch sử đặt hàng",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [Icon(Icons.navigate_next)],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistorySearchScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 30,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Lịch sử tìm kiếm",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [Icon(Icons.navigate_next)],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          bottomNavigationModel.setSelectedIndex(2);
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 30,
                              color: Color.fromARGB(255, 255, 0, 149),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sản phẩm yêu thích",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    children: [Icon(Icons.navigate_next)],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewedproductScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.list_alt_outlined,
                              size: 30,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sản phẩm đã xem",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [Icon(Icons.navigate_next)],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserDiscountCodeScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.sell_outlined,
                              size: 30,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Khuyến mãi đã lưu",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [Icon(Icons.navigate_next)],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
