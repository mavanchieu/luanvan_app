import 'package:app_lv/client/manager/gender_manager.dart';
import 'package:app_lv/client/manager/discountCodes_manager.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/manager/userDiscountCode.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DiscountCodesScreen extends StatefulWidget {
  const DiscountCodesScreen({super.key});

  @override
  State<DiscountCodesScreen> createState() => _DiscountCodesScreenState();
}

class _DiscountCodesScreenState extends State<DiscountCodesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DiscountcodesManager>().fetchDiscountCodes();
    // context.read<GenderManager>().fetchGenders();
    context
        .read<UserDiscountCodeManager>()
        .fetchUserDiscountCodeByUserId(context.read<LoginService>().userId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Khuyến Mãi Của Cửa Hàng",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 236, 232, 232),
            ),
            child: Consumer2<DiscountcodesManager, UserDiscountCodeManager>(
              builder: (context, value, value2, child) {
                if (value.discountCodes.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: value.discountCodes.length,
                    itemBuilder: (context, index) {
                      bool result = value2.userDiscountCodesByUserId.any(
                          (element) =>
                              element.discountCodeId ==
                              value.discountCodes[index].id);
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                          bottom: 10,
                          right: 6,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Giảm ${value.discountCodes[index].discount}%",
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Đơn tối thiểu ${value.discountCodes[index].price} vnd",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 105, 105, 105)),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: result == false
                                          ? ElevatedButton(
                                              onPressed: () async {
                                                context
                                                    .read<
                                                        UserDiscountCodeManager>()
                                                    .createUserDiscountCode(
                                                        context
                                                            .read<
                                                                LoginService>()
                                                            .userId,
                                                        value
                                                            .discountCodes[
                                                                index]
                                                            .id);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  side: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 1, 59, 19),
                                                      width: 0.5),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 18, 168, 45)),
                                              child: const Text(
                                                "Lưu",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                              ))
                                          : ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  side: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 1, 59, 19),
                                                      width: 0.5),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 18, 168, 45)),
                                              child: const Text(
                                                "Đã lưu",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [Text("hahahaah")],
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
