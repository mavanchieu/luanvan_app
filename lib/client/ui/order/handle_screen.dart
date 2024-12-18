import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/manager/userDiscountCode.dart';
import 'package:app_lv/client/models/userDiscountCode.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/order/not_payment_screen.dart';
import 'package:app_lv/client/ui/order/order_detail/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HandleScreen extends StatefulWidget {
  const HandleScreen({super.key});

  @override
  State<HandleScreen> createState() => _HandleScreenState();
}

class _HandleScreenState extends State<HandleScreen> {
  final SocketService socketService = SocketService();

  @override
  void initState() {
    super.initState();
    socketService.connect();
    context
        .read<ProductManager>()
        .fetchOrders(context.read<LoginService>().userId);
    socketService.on('deleteOneOrder', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('deleteOneOrder: $data');
        await context
            .read<ProductManager>()
            .fetchOrders(context.read<LoginService>().userId);
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

    socketService.on('createOrder', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('createOrder: $data');
        await context
            .read<ProductManager>()
            .fetchOrders(context.read<LoginService>().userId);
      }
    });
    socketService.on('confirmOrder', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('confirmOrder: $data');
        await context
            .read<ProductManager>()
            .fetchOrders(context.read<LoginService>().userId);
      }
    });
  }

  @override
  void _showConfirmationDialog(
      BuildContext context, String orderId, String userDiscountCodeId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Hủy đơn hàng'),
          content: const Text('Bạn có chắc chắn hủy đơn hàng này?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () async {
                bool success = await context
                    .read<ProductManager>()
                    .deleteOneOrder(orderId, userDiscountCodeId);
                Navigator.of(dialogContext).pop();
                if (success) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(content: Text('Bạn đã hủy thành công')),
                  );
                } else {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                        content: Text('Có lỗi xảy ra khi xóa đơn hàng')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Consumer<ProductManager>(
            builder: (context, value, child) {
              if (value.handleOrders.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.handleOrders.length,
                    itemBuilder: (context, index) {
                      final order = value.handleOrders[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailScreen(order: order),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hiển thị thông tin chung của đơn hàng
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 211, 215, 211),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      order.fullname,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "Đang chờ xác nhận",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Hiển thị danh sách sản phẩm của đơn hàng
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: order.products.length,
                                itemBuilder: (context, productIndex) {
                                  final product = order.products[productIndex];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(0.3),
                                        1: FlexColumnWidth(0.7),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                      'http://192.168.56.1:3005/orders/${change(product.image)}'),
                                                ],
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.productName,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Phân loại: ${product.colorItemName}, ${product.sizeName}",
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 111, 111, 111),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Số lượng: ${product.quantity}",
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 111, 111, 111),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${NumberFormat('#,##0', 'vi_VN').format(product.price!)} vnd",
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    product.discount != 0
                                                        ? Text(
                                                            "Giảm giá: ${product.discount}%",
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                              fontSize: 17,
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "Tổng thanh toán: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${NumberFormat('#,##0', 'vi_VN').format(order.totalPrice)} vnd",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    _showConfirmationDialog(context, order.id,
                                        order.userDiscountCodeId!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 252, 220, 220),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  child: const Text(
                                    "Hủy Đơn",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return NotPaymentScreen();
              }
            },
          )
        ],
      ),
    );
  }
}
