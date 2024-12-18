import 'package:app_lv/client/models/cart_model.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/cart/cart_screen.dart';
import 'package:app_lv/client/ui/payment/payment_screen.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:app_lv/client/ui/shared/top_right_badge.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AllCartScreen extends StatefulWidget {
  final ScrollController scrollController;
  const AllCartScreen({super.key, required this.scrollController});

  @override
  State<AllCartScreen> createState() => _AllCartScreenState();
}

class _AllCartScreenState extends State<AllCartScreen> {
  final SocketService socketService = SocketService();
  @override
  void initState() {
    super.initState();
    socketService.connect();
    context.read<ProductManager>().fetchAllProducts();
    context
        .read<ProductManager>()
        .fetchCarts(context.read<LoginService>().userId);

    socketService.on('createCart', (data) async {
      if (mounted) {
        print('New cart received: $data');
        await context.read<ProductManager>().fetchAllProducts();
        await context
            .read<ProductManager>()
            .fetchCarts(context.read<LoginService>().userId);
      }
    });

    socketService.on('orderStatus', (data) async {
      if (mounted) {
        print('New cart received: $data');
        await context.read<ProductManager>().fetchAllProducts();
        await context
            .read<ProductManager>()
            .fetchCarts(context.read<LoginService>().userId);
      }
    });
    socketService.on('createCart', (data) async {
      if (mounted) {
        print('New cart received: $data');
        await context.read<ProductManager>().fetchAllProducts();
        await context
            .read<ProductManager>()
            .fetchCarts(context.read<LoginService>().userId);
      }
    });
    socketService.on('deleteOneCart', (data) async {
      if (mounted) {
        print('DeleteOne: $data');
        await context.read<ProductManager>().fetchAllProducts();
        await context
            .read<ProductManager>()
            .fetchCarts(context.read<LoginService>().userId);
      }
    });
    socketService.on('updateCart', (data) async {
      if (mounted) {
        print('Update: $data');
        await context.read<ProductManager>().fetchAllProducts();
        await context
            .read<ProductManager>()
            .fetchCarts(context.read<LoginService>().userId);
      }
    });
    socketService.on('deleteAllCart', (data) async {
      if (mounted) {
        print('Update: $data');
        await context.read<ProductManager>().fetchAllProducts();
        await context
            .read<ProductManager>()
            .fetchCarts(context.read<LoginService>().userId);
      }
    });

    socketService.on('updateProduct', (data) async {
      if (mounted) {
        print('Update: $data');
        await context.read<ProductManager>().fetchAllProducts();
        await context
            .read<ProductManager>()
            .fetchCarts(context.read<LoginService>().userId);
      }
    });

    socketService.on('productHidden', (data) async {
      await context.read<ProductManager>().fetchAllProducts();
      await context
          .read<ProductManager>()
          .fetchCarts(context.read<LoginService>().userId);
    });
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  Future<void> _submit() async {
    try {
      bool result = await context
          .read<ProductManager>()
          .deleteAllCart(context.read<LoginService>().userId);
      if (result == false) {
        await showErrorDialog(context, "Xóa không thành công!");
      } else {
        await toast(context, "Bạn đã xóa giỏ hàng thành công");
      }
    } catch (error) {
      if (mounted) {
        print("Đã xảy ra lỗi: $error");
        await showErrorDialog(context, "Xóa không thành công!");
      }
    }
  }

  @override
  void _showModelBottomSheet(BuildContext context, CartModel cart) {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      // backgroundColor: Color.fromARGB(0, 255, 255, 255),
      // builder: (context) {
      // return GestureDetector(
      //   behavior: HitTestBehavior.opaque,
      //   onTap: () {
      //     Navigator.of(context).pop();
      //   },
      //   child: SizedBox(
      //     height: 680,
      //     child: DraggableScrollableSheet(
      //       expand: false,
      //       builder: (context, scrollController) {
      //         return Container(
      //           decoration: const BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(20),
      //               topRight: Radius.circular(20),
      //             ),
      //           ),
      //           child: StatefulBuilder(
      //             builder: (context, setBottomSheetState) {
      //               return Padding(
      //                 padding: const EdgeInsets.all(20),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         const Text(
      //                           "LỰA CHỌN",
      //                           style: TextStyle(
      //                             fontSize: 20,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                         IconButton(
      //                           onPressed: () {
      //                             Navigator.pop(context);
      //                           },
      //                           icon: const Icon(
      //                             Icons.close,
      //                             color: Color.fromARGB(255, 116, 116, 116),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(top: 20),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Row(
      //                             children: [
      //                               const Icon(
      //                                 Icons.add_box_outlined,
      //                                 size: 30,
      //                               ),
      //                               const SizedBox(
      //                                 width: 20,
      //                               ),
      //                               const Text(
      //                                 "Số lượng",
      //                                 style: TextStyle(fontSize: 19),
      //                               ),
      //                               IconButton(
      //                                   onPressed: () {
      //                                     setBottomSheetState(() async {
      //                                       if (cart.quantity > 1) {
      //                                         cart.quantity =
      //                                             cart.quantity - 1;
      //                                         String message = await context
      //                                             .read<ProductManager>()
      //                                             .updateCart(cart);
      //                                         toast(context, message);
      //                                       }
      //                                     });
      //                                   },
      //                                   icon: const Icon(Icons.remove)),
      //                               Text(
      //                                 cart.quantity.toString(),
      //                                 style: const TextStyle(
      //                                   fontSize: 16,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               ),
      //                               IconButton(
      //                                   onPressed: () {
      //                                     setBottomSheetState(() async {
      //                                       cart.quantity = cart.quantity + 1;
      //                                       String message = await context
      //                                           .read<ProductManager>()
      //                                           .updateCart(cart);
      //                                       toast(context, message);
      //                                     });
      //                                   },
      //                                   icon: const Icon(Icons.add))
      //                             ],
      //                           ),
      //                           const Padding(
      //                             padding:
      //                                 EdgeInsets.only(top: 15, bottom: 15),
      //                             child: Divider(
      //                               thickness: 0.5,
      //                               color: Color.fromARGB(255, 0, 0, 0),
      //                             ),
      //                           ),
      //                           Row(
      //                             children: [
      //                               const Icon(
      //                                 Icons.shopping_bag_outlined,
      //                                 size: 30,
      //                               ),
      //                               const SizedBox(
      //                                 width: 20,
      //                               ),
      //                               GestureDetector(
      //                                 onTap: () async {
      //                                   // print(cart.id);
      //                                   await context
      //                                       .read<ProductManager>()
      //                                       .deleteOneCart(cart.id);
      //                                   Navigator.pop(context);
      //                                 },
      //                                 child: const Text(
      //                                   "Xóa khỏi giỏ hàng",
      //                                   style: TextStyle(fontSize: 19),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                           const Padding(
      //                             padding:
      //                                 EdgeInsets.only(top: 15, bottom: 15),
      //                             child: Divider(
      //                               thickness: 0.5,
      //                               color: Color.fromARGB(255, 0, 0, 0),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               );
      //             },
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      //);
      builder: (context) {
        return BottomSheetContent(cart: cart);
      },

      // },
    );
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
                    Icons.shopping_bag_outlined,
                    size: 25,
                    color: Colors.pink,
                  ),
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
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Chọn',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () {
                            _submit();
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
                title: const Text("Giỏ hàng"),
              ),
            ],
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<ProductManager>(
                      builder: (context, value, child) {
                        if (value.carts.isNotEmpty) {
                          return SizedBox(
                            height: value.carts.length > 2
                                ? MediaQuery.of(context).size.height *
                                    value.carts.length /
                                    2.8
                                : MediaQuery.of(context).size.height *
                                    value.carts.length,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.carts.length,
                              itemBuilder: (context, index) {
                                String productId = value.carts[index].productId;
                                String colorItemId =
                                    value.carts[index].colorItemId;
                                String sizeId = value.carts[index].sizeId;
                                var product = value.allProducts.firstWhere(
                                    (element) => element.id == productId);
                                var color = product.colors!.firstWhere(
                                    (element) => element.id! == colorItemId);
                                var size = color.sizes!.firstWhere(
                                    (element) => element.id! == sizeId);

                                return Column(
                                  children: [
                                    product.hidden == true
                                        ? const Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Sản phẩm không khả dụng, vui lòng xóa trước khi thanh toán!',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.network(
                                                        "http://192.168.56.1:3005/${change(color.images![0])}",
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        product.name!,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
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
                                                          child: Text(
                                                            "${NumberFormat('#,##0', 'vi_VN').format(color.price!)} vnd",
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                                    fontSize:
                                                                        17),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            "Màu: ",
                                                            style: TextStyle(
                                                                fontSize: 17),
                                                          ),
                                                          Text(
                                                            color.name!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        17),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            "Size: ",
                                                            style: TextStyle(
                                                                fontSize: 17),
                                                          ),
                                                          Text(
                                                            size.name!,
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            "Số lượng: ",
                                                            style: TextStyle(
                                                                fontSize: 17),
                                                          ),
                                                          Text(
                                                            "x${value.carts[index].quantity}",
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      product.discount! != 0
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Giảm: ",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${product.discount}%",
                                                                  style: GoogleFonts
                                                                      .aBeeZee(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                      const Divider(
                                                        thickness: 0.5,
                                                        color: Colors.black,
                                                      ),
                                                      const Text(
                                                        "Tạm tính ",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                          "${NumberFormat('#,##0', 'vi_VN').format(value.carts[index].quantity * (color.price! - (color.price! * product.discount! / 100)))} vnd",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.pink,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 0),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          _showModelBottomSheet(
                                                              context,
                                                              value.carts[
                                                                  index]);
                                                        },
                                                        icon: const Icon(Icons
                                                            .more_vert_outlined),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return const NotCart();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<ProductManager>(
            builder: (context, value, child) {
              bool hasUnavailableProducts = value.carts.any((cart) {
                var product = value.allProducts
                    .firstWhere((element) => element.id == cart.productId);
                return product.hidden == true;
              });
              if (value.carts.isNotEmpty) {
                return Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "TỔNG",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Consumer<ProductManager>(
                                builder: (context, value, child) {
                                  if (value.carts.isNotEmpty) {
                                    return Text(
                                      "${NumberFormat('#,##0', 'vi_VN').format(value.totalPrice())} vnd",
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      "0 VND",
                                      style: GoogleFonts.aBeeZee(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: hasUnavailableProducts
                                ? null // Vô hiệu hóa nếu có sản phẩm không khả dụng
                                : () {
                                    // Thực hiện logic thanh toán
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (conetxt) =>
                                            const PaymentScreen(),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hasUnavailableProducts
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                            child: hasUnavailableProducts
                                ? Text('Không thể thanh toán')
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "THANH TOÁN",
                                        style: TextStyle(
                                          fontSize: 21,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next_outlined,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                          ),

                          // onPressed: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (conetxt) => const PaymentScreen(),
                          //     ),
                          //   );
                          // },
                          // style: ElevatedButton.styleFrom(
                          //   backgroundColor: Colors.black,
                          //   shape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.zero,
                          //   ),
                          // ),
                          // child: const Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "THANH TOÁN",
                          //         style: TextStyle(
                          //           fontSize: 21,
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //       Icon(
                          //         Icons.navigate_next_outlined,
                          //         color: Colors.white,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  final CartModel cart;

  const BottomSheetContent({Key? key, required this.cart}) : super(key: key);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.cart.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.plus_one,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Số lượng",
                style: TextStyle(fontSize: 19),
              ),
              IconButton(
                onPressed: () async {
                  if (quantity > 1) {
                    setState(() {
                      quantity -= 1;
                    });
                    widget.cart.quantity = quantity;
                    String message = await context
                        .read<ProductManager>()
                        .updateCart(widget.cart);
                    toast(context, message);
                  }
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    quantity += 1;
                  });
                  widget.cart.quantity = quantity;
                  String message = await context
                      .read<ProductManager>()
                      .updateCart(widget.cart);
                  toast(context, message);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 1, bottom: 15),
          child: Divider(
            thickness: 0.5,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {
                // print(cart.id);
                await context
                    .read<ProductManager>()
                    .deleteOneCart(widget.cart.id);
                Navigator.pop(context);
              },
              child: const Text(
                "Xóa khỏi giỏ hàng",
                style: TextStyle(fontSize: 19),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          child: Divider(
            thickness: 0.5,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ],
    );
  }
}
