import 'package:app_lv/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:app_lv/client/ui/cart/all_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final ScrollController scrollController;
  const CartScreen({super.key, required this.scrollController});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            //return NotCart(scrollController: widget.scrollController);
            return AllCartScreen(scrollController: widget.scrollController);
          },
        );
      },
    );
  }
}

class NotCart extends StatefulWidget {
  const NotCart({super.key});

  @override
  State<NotCart> createState() => _NotCartState();
}

class _NotCartState extends State<NotCart> {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "KHÔNG CÓ SẢN PHẨM NÀO",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Row(
                          children: [
                            Text(
                              "Hãy thêm sản phẩm muốn mua vào giỏ hàng",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              bottomNavigationModel.setSelectedIndex(1);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MUA NGAY',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
            //NotCart(),
            //AllCartScreen(),
          ],
        ),
      ),
    );
  }
}
