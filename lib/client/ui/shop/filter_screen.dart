import 'package:app_lv/client/manager/brand_manager.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/manager/typeDetail_manager.dart';
import 'package:app_lv/client/models/brand_model.dart';
import 'package:app_lv/client/models/typeDetail_model.dart';
import 'package:app_lv/client/ui/product/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  final List<String> selectedBrandIds;
  final List<String> selectedTypeDetailIds;
  final String genderId;
  const FilterScreen({
    super.key,
    required this.selectedBrandIds,
    required this.selectedTypeDetailIds,
    required this.genderId,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<BrandModel> brands = [];
  List<TypeDetailModel> typeDetails = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductManager>().fetchFilter(
        widget.genderId, widget.selectedBrandIds, widget.selectedTypeDetailIds);
    fetchBrands();
    fetchAllTypeDetailsByGenderId();
  }

  Future<List<BrandModel>> fetchBrands() async {
    brands = await context.read<BrandManager>().fetchBrands();
    return brands;
  }

  Future<List<TypeDetailModel>> fetchAllTypeDetailsByGenderId() async {
    typeDetails = await context
        .read<TypeDetailManager>()
        .fetchAllTypeDetailsByGenderId(widget.genderId);
    return typeDetails;
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
        title: Text("Lọc"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ProductManager>(builder: (context, value, child) {
              if (value.filters.isNotEmpty) {
                return SizedBox(
                  // height: value.filters.length * 170,
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
                        itemCount: value.filters.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                      id: value.filters[index].id!),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
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
                                                "http://192.168.56.1:3005/${change(value.filters[index].colors![0].images![0])}",
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
                                              "${NumberFormat('#,##0', 'vi_VN').format(value.filters[index].colors![0].price)} vnd",
                                              style: GoogleFonts.aBeeZee(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        value.products[index].discount! != 0
                                            ? Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
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
                                                    "-${value.filters[index].discount!}%",
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
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            newName(value.filters[index].name!),
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 20,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          brandName(
                                              value.filters[index].brandId),
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 72, 70, 70),
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
                    "Hiện tại chưa có sản phẩm nào theo bộ lọc!",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
