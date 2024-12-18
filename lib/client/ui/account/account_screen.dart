import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/account/body/account_body_screen.dart';
import 'package:app_lv/client/ui/account/body/message/message_screen.dart';
import 'package:app_lv/client/ui/account/header/account_header_screen.dart';
import 'package:app_lv/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:app_lv/client/ui/login/login_screen.dart';
import 'package:app_lv/client/ui/order/evaluation/star.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  final ScrollController scrollController;
  const AccountScreen({super.key, required this.scrollController});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Đăng Xuất'),
          content: const Text('Bạn có chắc chắn đăng xuất?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () async {
                context.read<LoginService>().logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
                Navigator.of(dialogContext).pop();

                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  const SnackBar(content: Text('Bạn đã đăng xuất thành công')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return NestedScrollView(
              controller: widget.scrollController,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsSCrolled) => [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  snap: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(4.0),
                    child: Container(
                      color: const Color.fromARGB(255, 213, 211, 211),
                      height: 1.0,
                    ),
                  ),
                  title: const Text(
                    "Tài khoản cá nhân",
                    style: TextStyle(
                      //  fontWeight: FontWeight.bold,

                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
              ],
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(255, 240, 237, 237),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const AccountHeaderScreen(),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 8, bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MessageScreen()));
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Chat với cửa hàng",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 52, 2, 189),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const AccountBodyScreen(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // Tắt border radius
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ĐĂNG XUẤT",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.logout_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Divider(
                          color: Color.fromARGB(255, 100, 107, 108),
                          thickness: 0.5,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Phiên bản v.10",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(
                                    200,
                                    0,
                                    0,
                                    0,
                                  ),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
