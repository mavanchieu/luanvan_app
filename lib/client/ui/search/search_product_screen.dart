import 'package:app_lv/client/manager/brand_manager.dart';
import 'package:app_lv/client/models/brand_model.dart';
import 'package:app_lv/client/ui/product/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../manager/product_manager.dart';

class SearchProductScreen extends StatefulWidget {
  final String searchName;
  const SearchProductScreen({
    super.key,
    required this.searchName,
  });

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  List<BrandModel> brands = [];
  @override
  void initState() {
    super.initState();
    context.read<ProductManager>().fetchSearchProduct(widget.searchName);
    fetchBrands();
  }

  Future<List<BrandModel>> fetchBrands() async {
    brands = await context.read<BrandManager>().fetchBrands();
    setState(() {});
    return brands;
  }

  String brandName(String brandId) {
    if (brands.isNotEmpty) {
      BrandModel brand = brands.firstWhere((element) => element.id == brandId);
      return brand.name;
    }
    return "Trống";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Danh sách sản phẩm tìm kiếm",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 233, 231, 231),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8, bottom: 8, left: 2, right: 2),
                child:
                    Consumer<ProductManager>(builder: (context, value, child) {
                  if (value.searchList.isNotEmpty) {
                    return SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 1.3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: value.searchList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                          id: value.searchList[index].id!),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 205,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    "http://192.168.56.1:3005/${change(value.searchList[index].colors![0].images![0])}",
                                                  ),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              left: 10,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                color: const Color.fromARGB(
                                                    136, 100, 99, 99),
                                                child: Text(
                                                  "${value.searchList[index].colors![0].price} vnd",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            value.searchList[index].discount! !=
                                                    0
                                                ? Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            137, 210, 155, 155),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Text(
                                                        "-${value.searchList[index].discount!}%",
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 249, 1, 1),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              newName(value
                                                  .searchList[index].name!),
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              brandName(
                                                value.searchList[index].brandId,
                                              ),
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 72, 70, 70),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 70,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.yellow,
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromARGB(
                                                    255, 237, 232, 188),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Color.fromARGB(
                                                        255, 255, 230, 0),
                                                  ),
                                                  Text(
                                                    "4.9",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Hiện tại chưa có sản phẩm nào!",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
