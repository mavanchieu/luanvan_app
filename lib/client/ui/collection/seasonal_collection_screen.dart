import 'package:app_lv/client/manager/collection_manager.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/ui/product/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SeasonalCollectionScreen extends StatefulWidget {
  final String id;
  const SeasonalCollectionScreen({super.key, required this.id});

  @override
  State<SeasonalCollectionScreen> createState() =>
      _SeasonalCollectionScreenState();
}

class _SeasonalCollectionScreenState extends State<SeasonalCollectionScreen> {
  @override
  void initState() {
    super.initState();
    _initializeData();
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

  Future<void> _initializeData() async {
    await context.read<CollectionManager>().fetchAllSeasonalCollection();
    await context
        .read<CollectionManager>()
        .fetchOneSeasonalCollection(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hhhahaahah"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Consumer2<CollectionManager, ProductManager>(
                  builder: (context, value, value1, child) {
                if (value.seasonalCollectionById.id! != "") {
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
                      itemCount:
                          value.seasonalCollectionById.productIds!.length,
                      itemBuilder: (context, index) {
                        var product = value1.allProducts.firstWhere(
                          (element) =>
                              element.id! ==
                              value.seasonalCollectionById.productIds![index],
                        );
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(id: product.id!),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 195, 195, 195),
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(5),
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
                                              "http://192.168.56.1:3005/${change(product.colors![0].images![0])}",
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
                                            "${NumberFormat('#,##0', 'vi_VN').format(product.colors![0].price)} vnd",
                                            style: GoogleFonts.aBeeZee(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      product.discount! != 0
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
                                                  "-${product.discount!}%",
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
                                      Text(
                                        newName(product.name!),
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Text(
                    "Không có sản phẩm nào!",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
