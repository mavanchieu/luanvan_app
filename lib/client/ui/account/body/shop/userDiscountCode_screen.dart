import 'package:app_lv/client/manager/discountCodes_manager.dart';
import 'package:app_lv/client/manager/userDiscountCode.dart';
import 'package:app_lv/client/models/discountCodes.model.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDiscountCodeScreen extends StatefulWidget {
  const UserDiscountCodeScreen({super.key});

  @override
  State<UserDiscountCodeScreen> createState() => _UserDiscountCodeScreenState();
}

class _UserDiscountCodeScreenState extends State<UserDiscountCodeScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<UserDiscountCodeManager>()
        .fetchUserDiscountCodeByUserId(context.read<LoginService>().userId);
    context.read<DiscountcodesManager>().fetchDiscountCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khuyến mãi đã lưu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer2<UserDiscountCodeManager, DiscountcodesManager>(
                builder: (context, value, value2, child) {
              if (value.userDiscountCodesByUserId.isNotEmpty) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.userDiscountCodesByUserId.length,
                  itemBuilder: (context, index) {
                    List<DiscountCodesModel> discountCode = value2.discountCodes
                        .where((element) =>
                            element.id ==
                            value.userDiscountCodesByUserId[index]
                                .discountCodeId!)
                        .toList();
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text("Mã khuyến mãi + ${discountCode[0].code}")
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const Text('Bạn không có mã khuyến mãi nào');
              }
            })
          ],
        ),
      ),
    );
  }
}
