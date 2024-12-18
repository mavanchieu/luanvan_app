import 'package:app_lv/client/ui/order/deliverry.dart';
import 'package:app_lv/client/ui/order/evaluation/evaluation__screen.dart';
import 'package:app_lv/client/ui/order/handle_screen.dart';
import 'package:app_lv/client/ui/order/not_payment_screen.dart';
import 'package:app_lv/client/ui/order/ordered_screen.dart';
import 'package:flutter/material.dart';

class AllOrderScreen extends StatefulWidget {
  final int index;
  const AllOrderScreen({super.key, required this.index});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  int _selectedWidget = 0;

  final List<Widget> _listWidget = [
    // const NotPaymentScreen(),
    const HandleScreen(),
    const OrderedScreen(),
    const DeliveryScreen(),
    const EvaluationScreen(),
    const NotPaymentScreen(),
  ];

  final List<String> _listName = [
    "Xử lý",
    "Đã xác nhận",
    "Đang giao",
    "Đánh giá",
    "Trả lại"
  ];
  @override
  void initState() {
    _selectedWidget = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Đơn hàng của tôi",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Divider(
                  thickness: 0.5,
                  color: Color.fromARGB(255, 184, 183, 183),
                ),
                Column(
                  children: [
                    _listWidget[_selectedWidget],
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Colors.white,
              child: SizedBox(
                height: 47,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _listName.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedWidget = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _selectedWidget == index
                                    ? Colors.black
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 5, right: 5),
                                child: Text(
                                  _listName[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedWidget == index
                                        ? Colors.black
                                        : const Color.fromARGB(255, 87, 87, 87),
                                  ),
                                ),
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
          )
        ],
      ),
    );
  }
}
