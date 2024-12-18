import 'dart:math';

import 'package:app_lv/client/manager/brand_manager.dart';
import 'package:app_lv/client/manager/collection_manager.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/models/brand_model.dart';
import 'package:app_lv/client/ui/product/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BrandCollectonScreen extends StatefulWidget {
  final String id;
  const BrandCollectonScreen({super.key, required this.id});

  @override
  State<BrandCollectonScreen> createState() => _BrandCollectonScreenState();
}

class _BrandCollectonScreenState extends State<BrandCollectonScreen> {
  // String brandName = "";
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await context.read<BrandManager>().fetchBrands();
    await context.read<ProductManager>().fetchAllProducts();
    await context.read<CollectionManager>().fetchAllBrandCollection();
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  String newName(String name) {
    if (name.length > 10) {
      name = name.substring(0, 10);
      name = "$name...";
    }
    return name;
  }
  // Future<String> brandName() async {
  //   List<BrandModel> brands = await context.read<BrandManager>().fetchBrands();
  //   var brand = brands.where((element) => element.id == widget.id).toList();
  //   if (brand.isNotEmpty) {
  //     return brand[0].name;
  //   } else {
  //     return "Lỗi";
  //   }
  //   // return brand.isNotEmpty ? brand[0].name : 'Unknown Brand';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<BrandManager>(
          builder: (context, value, child) {
            if (value.brands.isNotEmpty) {
              var brand = value.brands
                  .where((element) => element.id == widget.id)
                  .toList();
              return Text(brand[0].name);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Consumer2<ProductManager, CollectionManager>(
                  builder: (context, value, value1, child) {
                var brandProducts = value.allProducts
                    .where((element) => element.brandId == widget.id)
                    .toList();
                var products = value.allProducts
                    .where((element) => element.brandId == widget.id)
                    .toList();
                if (brandProducts.isNotEmpty) {
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1.3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                    id: products[index].id!),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 195, 195, 195),
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 220,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "http://192.168.56.1:3005/${change(products[index].colors![0].images![0])}",
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          color: const Color.fromARGB(
                                              136, 100, 99, 99),
                                          child: Text(
                                            "${NumberFormat('#,##0', 'vi_VN').format(products[index].colors![0].price)} vnd",
                                            style: GoogleFonts.aBeeZee(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      products[index].discount! != 0
                                          ? Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      137, 210, 155, 155),
                                                  // borderRadius:
                                                  //     BorderRadius.only(
                                                  //   topRight:
                                                  //       Radius.circular(10),
                                                  // ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  "-${products[index].discount!}%",
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 249, 1, 1),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(newName(products[index].name!),
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: 20,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Không có sản phẩm nào!",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
