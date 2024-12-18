import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/account/body/system/help/help_manager.dart';
import 'package:app_lv/client/ui/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_lv/client/ui/account/body/shop/shop_body_screen.dart';
import 'package:app_lv/client/ui/account/body/system_body_screen.dart';
import 'package:app_lv/client/ui/account/body/user_body_screen.dart';
import 'package:provider/provider.dart';

class AccountBodyScreen extends StatefulWidget {
  const AccountBodyScreen({super.key});

  @override
  State<AccountBodyScreen> createState() => _AccountBodyScreenState();
}

class _AccountBodyScreenState extends State<AccountBodyScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<HelpManager>()
        .fetchByUserId(context.read<LoginService>().userId);
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OrderScreen(),
        UserScreen(),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Divider(
            color: Color.fromARGB(255, 100, 107, 108),
            thickness: 0.5,
          ),
        ),
        ShopScreen(),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Divider(
            color: Color.fromARGB(255, 100, 107, 108),
            thickness: 0.5,
          ),
        ),
        SystemScreen(),
      ],
    );
  }
}
