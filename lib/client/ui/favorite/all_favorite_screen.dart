import 'dart:io';
import 'dart:math';

import 'package:app_lv/client/manager/favroite_manager.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:app_lv/client/ui/favorite/favorite_screen.dart';
import 'package:app_lv/client/ui/product/product_detail/product_detail_screen.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/ui/shared/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AllFavoriteScreen extends StatefulWidget {
  final ScrollController scrollController;
  const AllFavoriteScreen({super.key, required this.scrollController});

  @override
  State<AllFavoriteScreen> createState() => _AllFavoriteScreenState();
}

class _AllFavoriteScreenState extends State<AllFavoriteScreen> {
  final SocketService socketService = SocketService();
  @override
  void _showModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            height: 410,
            child: DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "SORT BY",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Color.fromARGB(255, 116, 116, 116),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Giá giảm",
                                style: TextStyle(fontSize: 20),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, right: 8),
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 0.5,
                                ),
                              ),
                              Text(
                                "Giá tăng",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUserFavorites();
    socketService.connect();

    final userId = context.read<LoginService>().userId;

    // Safely handle WebSocket events
    socketService.on('createFavorite', (data) async {
      if (mounted) {
        print('New favorite received: $data');
        await fetchUserFavorites();
      }
    });

    socketService.on('deteleOneFavorite', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('Favorite deleted: $data');
        await fetchUserFavorites();
      }
    });

    socketService.on('deteleAllFavorite', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('Favorite deleted: $data');
        await fetchUserFavorites();
      }
    });
  }

  Future<void> fetchUserFavorites() async {
    try {
      // Check if the widget is still mounted before performing any actions with context
      if (!mounted) return;

      final userId = context.read<LoginService>().userId; // Get the userId

      // Fetch favorites and products
      await context.read<FavoriteManager>().fetchFavorites(userId);
      await context.read<ProductManager>().fetchProduct(); // Fetch products

      print('Favorites fetched successfully');
    } catch (error) {
      if (mounted) {
        print('Error fetching favorites: $error');
      }
    }
  }

  // @override
  // void dispose() {
  //   // Disconnect WebSocket and cancel listeners
  //   socketService.disconnect();
  //   super.dispose();
  // }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
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
                actions: [
                  const Icon(
                    Icons.favorite_outline,
                    color: Colors.pink,
                    size: 25,
                  ),
                  PopupMenuButton(
                    color: const Color.fromARGB(221, 0, 0, 0),
                    iconColor: Colors.black,
                    onSelected: (value) => (),
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                    itemBuilder: (ctx) => [
                      // PopupMenuItem(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       Navigator.pop(context);
                      //     },
                      //     child: const Text(
                      //       'Chọn',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () async {
                            await context
                                .read<FavoriteManager>()
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
                title: const Text("Yêu thích"),
              ),
            ],
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer2<FavoriteManager, ProductManager>(
                      builder: (context, value1, value2, child) {
                        if (value1.favorites.isNotEmpty) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value1.favorites.length,
                            itemBuilder: (context, index) {
                              String productId =
                                  value1.favorites[index].productId;

                              var products = value2.products
                                  .where((element) => element.id == productId)
                                  .toList();
                              if (products.isNotEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(0.4),
                                      1: FlexColumnWidth(0.5),
                                      2: FlexColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 222, 220, 220),
                                        ),
                                        children: [
                                          TableCell(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.network(
                                                    "http://192.168.56.1:3005/${change(products[0].colors![0].images![0])}",
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                " ${NumberFormat('#,##0', 'vi_VN').format(products[0].colors![0].price)} vnd",
                                                                style:
                                                                    GoogleFonts
                                                                        .aBeeZee(
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              value1.deleteOne(
                                                                  context
                                                                      .read<
                                                                          LoginService>()
                                                                      .userId,
                                                                  productId);
                                                            },
                                                            icon: const Icon(
                                                              Icons.favorite,
                                                              color:
                                                                  Colors.pink,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    products[0].name!,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 175,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetailScreen(
                                                                    id: productId),
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                223, 222, 222),
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.zero,
                                                        ),
                                                        elevation: 5,
                                                        side: const BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                                      child: const Row(
                                                        children: [
                                                          Text(
                                                            "XEM CHI TIẾT",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          );
                        } else {
                          return const NotFavorite();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<FavoriteManager>(
                  builder: (context, value, child) {
                    if (value.favorites.isNotEmpty) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${value.favorites.length} sản phẩm",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _showModelBottomSheet(context);
                                  },
                                  child: Image.asset(
                                      "assets/image/favorite/sort_by.png")),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Text(
                        "0 sản phẩm",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
