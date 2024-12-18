import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/order/not_payment_screen.dart';
import 'package:app_lv/client/ui/order/order_detail/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final SocketService socketService = SocketService();
  @override
  void initState() {
    super.initState();
    socketService.connect();
    context
        .read<ProductManager>()
        .fetchOrders(context.read<LoginService>().userId);
    socketService.on('confirmCompletedOrder', (data) async {
      if (mounted) {
        print('confirmCompletedOrder: $data');
        await context
            .read<ProductManager>()
            .fetchOrders(context.read<LoginService>().userId);
      }
    });
    socketService.on('confirmShipping', (data) async {
      if (mounted) {
        print('confirmOrder: $data');
        await context
            .read<ProductManager>()
            .fetchOrders(context.read<LoginService>().userId);
      }
    });
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
              if (value.orderDelivery.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.orderDelivery.length,
                    itemBuilder: (context, index) {
                      final order = value.orderDelivery[index];
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
                                child: Column(
                                  children: [
                                    Row(
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
                                          "Đang giao",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ngày nhận: ${order.fromDate!} - ${order.toDate!}",
                                          style: GoogleFonts.aBeeZee(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 126, 152),
                                          ),
                                        ),
                                      ],
                                    )
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
                                                    'http://192.168.56.1:3005/orders/${change(product.image)}',
                                                  ),
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
