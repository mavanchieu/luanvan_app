import 'dart:async';

import 'package:app_lv/client/manager/brand_manager.dart';
import 'package:app_lv/client/manager/typeDetail_manager.dart';
import 'package:app_lv/client/models/brand_model.dart';
import 'package:app_lv/client/models/typeDetail_model.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/product/product_detail/product_detail_screen.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/ui/shop/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AllProducts extends StatefulWidget {
  final String genderId;
  final String genderName;
  const AllProducts({
    super.key,
    required this.genderId,
    required this.genderName,
  });

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final SocketService socketService = SocketService();
  List<BrandModel> brands = [];
  List<TypeDetailModel> typeDetails = [];
  List<String> selectedBrandIds = []; // List to hold selected brand IDs
  List<String> selectedTypeDetailIds = [];

  @override
  void initState() {
    super.initState();

    context.read<ProductManager>().fetchProductsByGenderId(widget.genderId);
    fetchBrands();
    fetchAllTypeDetailsByGenderId();
    socketService.connect();

    socketService.on('createFavorite', (data) async {
      await context
          .read<ProductManager>()
          .fetchProductsByGenderId(widget.genderId);
      await fetchBrands();
      await fetchAllTypeDetailsByGenderId();
      if (mounted) {
        print('New favorite received: $data');
      }
    });

    socketService.on('deleteOneFavorite', (data) async {
      await context
          .read<ProductManager>()
          .fetchProductsByGenderId(widget.genderId);
      await fetchBrands();
      await fetchAllTypeDetailsByGenderId();
      if (mounted) {
        print('Favorite deleted: $data');
      }
    });

    socketService.on('productHidden', (data) async {
      await context
          .read<ProductManager>()
          .fetchProductsByGenderId(widget.genderId);
      await fetchBrands();
      await fetchAllTypeDetailsByGenderId();
      if (mounted) {
        print('Favorite deleted: $data');
      }
    });

    socketService.on('deleteAllFavorite', (data) async {
      await context
          .read<ProductManager>()
          .fetchProductsByGenderId(widget.genderId);
      await fetchBrands();
      await fetchAllTypeDetailsByGenderId();
      if (mounted) {
        print('Favorite deleted: $data');
      }
    });
  }

  // @override
  // void dispose() {
  //   // Disconnect WebSocket and cancel listeners
  //   socketService.disconnect();
  //   super.dispose();
  // }

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
        title: Text("Sản phẩm ${widget.genderName}"),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Consumer<BrandManager>(
                builder: (context, value, child) {
                  if (value.brands.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.brands.length,
                      itemBuilder: (context, index) {
                        String brandId = value.brands[index].id;
                        return Column(
                          children: [
                            index == 0
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nhãn hiệu",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            CheckboxListTile(
                              title: Text(
                                brandName(brandId),
                                style: const TextStyle(fontSize: 17),
                              ),
                              value: selectedBrandIds.contains(brandId),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    selectedBrandIds.add(brandId);
                                  } else {
                                    selectedBrandIds.remove(brandId);
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Lỗi không tồn tại"),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Consumer<TypeDetailManager>(
                builder: (context, value, child) {
                  if (value.typeDetailsByGenderId.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.typeDetailsByGenderId.length,
                      itemBuilder: (context, index) {
                        String typeId = value.typeDetailsByGenderId[index].id;
                        return Column(
                          children: [
                            index == 0
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Loại sản phẩm",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: CheckboxListTile(
                                title: Text(
                                  value.typeDetailsByGenderId[index].name,
                                  style: const TextStyle(fontSize: 17),
                                ),
                                value: selectedTypeDetailIds.contains(typeId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedTypeDetailIds.add(typeId);
                                    } else {
                                      selectedTypeDetailIds.remove(typeId);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Lỗi không tồn tại"),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilterScreen(
                        selectedBrandIds: selectedBrandIds,
                        selectedTypeDetailIds: selectedTypeDetailIds,
                        genderId: widget.genderId,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  "Áp Dụng",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ProductManager>(builder: (context, value, child) {
              if (value.productsByGenderId.isNotEmpty) {
                return SizedBox(
                  // height: value.productsByGenderId.length * 170,
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
                        itemCount: value.productsByGenderId.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                      id: value.productsByGenderId[index].id!),
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
                                                "http://192.168.56.1:3005/${change(value.productsByGenderId[index].colors![0].images![0])}",
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
                                              "${NumberFormat('#,##0', 'vi_VN').format(value.productsByGenderId[index].colors![0].price)} vnd",
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
                                                    "-${value.productsByGenderId[index].discount!}%",
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
                                            newName(value
                                                .productsByGenderId[index]
                                                .name!),
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
                                          brandName(value
                                              .productsByGenderId[index]
                                              .brandId),
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
                    "Hiện tại chưa có sản phẩm nào!",
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
