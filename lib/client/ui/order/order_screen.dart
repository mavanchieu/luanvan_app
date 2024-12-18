import 'package:app_lv/client/ui/order/all_order_screen.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<String> _listImage = [
    "assets/icons/order/implement.png",
    "assets/icons/order/ordered.png",
    "assets/icons/order/shipping.png",
    "assets/icons/order/comment.png",
    "assets/icons/order/rollback.png",
  ];

  final List<String> _listName = [
    "Xử lý",
    "Đã xác nhận",
    "Đang giao",
    "Đánh giá",
    "Trả lại",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Đơn hàng của tôi',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 23, 0, 197),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllOrderScreen(
                          index: 0,
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        "Xem tất cả",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.navigate_next_outlined,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: _listImage.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 90,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AllOrderScreen(index: index),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              _listImage[index],
                              width: 40,
                            ),
                            Text(
                              _listName[index],
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
