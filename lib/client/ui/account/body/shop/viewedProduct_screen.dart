import 'package:app_lv/client/manager/brand_manager.dart';
import 'package:app_lv/client/manager/gender_manager.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/manager/viewedProduct_manager.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewedproductScreen extends StatefulWidget {
  const ViewedproductScreen({super.key});

  @override
  State<ViewedproductScreen> createState() => _ViewedproductScreenState();
}

class _ViewedproductScreenState extends State<ViewedproductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductManager>().fetchProduct();
    context
        .read<ViewedProductManager>()
        .fetchViewedProducts(context.read<LoginService>().userId);
    context.read<BrandManager>().fetchBrands();
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sản phẩm xem gần đây",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        actions: [
          PopupMenuButton(
            color: const Color.fromARGB(221, 0, 0, 0),
            iconColor: Colors.black,
            onSelected: (value) => (),
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () async {
                    await context
                        .read<ViewedProductManager>()
                        .deleteAll(context.read<LoginService>().userId);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Xóa tất cả',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 227, 226, 226),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Consumer3<ProductManager, ViewedProductManager, GenderManager>(
                  builder: (context, value1, value2, value3, _) {
                    if (value1.products.isNotEmpty &&
                        value2.viewedProducts.isNotEmpty &&
                        value3.genders.isNotEmpty) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        // scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: value2.viewedProducts.length,
                        itemBuilder: (context, index) {
                          var product = value1.products.firstWhere((element) =>
                              element.id ==
                              value2.viewedProducts[index].productId);
                          return Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Image.network(
                                    "http://192.168.56.1:3005/${change(product.colors![0].images![0])}",
                                    width: 180,
                                    height: 210,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    product.name!,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${NumberFormat('#,##0', 'vi_VN').format(product.colors![0].price!)} vnd",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Hiện tại bạn không có sản phẩm nào xem gần đây",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
