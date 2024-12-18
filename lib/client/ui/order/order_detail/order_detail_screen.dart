import 'package:app_lv/client/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết đơn hàng",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 217, 217, 217),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 60,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Column(
                    children: [
                      if (widget.order.status == '0')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Chờ xác nhận",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text("Đơn hàng của bạn đang chờ xác nhận"),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Tổng thanh toán: ",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 10, 10, 10),
                                  ),
                                ),
                                Text(
                                  "${NumberFormat('#,##0', 'vi_VN').format(widget.order.totalPrice)} vnd",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18,
                                    color: const Color.fromARGB(255, 255, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (widget.order.status == '1')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Đã xác nhận",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text("Đơn hàng của bạn đã được xác nhận"),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Tổng thanh toán: ",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 10, 10, 10),
                                  ),
                                ),
                                Text(
                                  "${NumberFormat('#,##0', 'vi_VN').format(widget.order.totalPrice)} vnd",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18,
                                    color: const Color.fromARGB(255, 255, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      if (widget.order.status == '3')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Đang giao",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text("Đơn hàng của bạn đang giao"),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Tổng thanh toán: ",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 10, 10, 10),
                                  ),
                                ),
                                Text(
                                  "${NumberFormat('#,##0', 'vi_VN').format(widget.order.totalPrice)} vnd",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18,
                                    color: const Color.fromARGB(255, 255, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Thông tin đơn hàng",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Mã đơn hàng',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              widget.order.id,
                              style: GoogleFonts.aBeeZee(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Ngày, giờ đặt',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              widget.order.date,
                              style: GoogleFonts.aBeeZee(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      widget.order.fromDate! != ""
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Ngày nhận hàng',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "${widget.order.fromDate!} - ${widget.order.toDate!}",
                                    style: GoogleFonts.aBeeZee(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Phương thức thanh toán',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              widget.order.paymentMethod,
                              style: GoogleFonts.aBeeZee(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Thông tin người nhận",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Người nhận',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              widget.order.fullname,
                              style: GoogleFonts.aBeeZee(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.phone,
                            ),
                            Text(
                              widget.order.phone,
                              style: GoogleFonts.aBeeZee(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.email,
                            ),
                            Text(
                              widget.order.email,
                              style: GoogleFonts.aBeeZee(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.blueAccent,
                            ),
                            Text(
                              widget.order.address,
                              style: GoogleFonts.aBeeZee(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Thông tin sản phẩm",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.order.products.length,
                        itemBuilder: (context, productIndex) {
                          final product = widget.order.products[productIndex];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Phân loại: ${product.colorItemName}, ${product.sizeName}",
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: const Color.fromARGB(
                                                    255, 111, 111, 111),
                                              ),
                                            ),
                                            Text(
                                              "Số lượng: ${product.quantity}",
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: const Color.fromARGB(
                                                    255, 111, 111, 111),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${NumberFormat('#,##0', 'vi_VN').format(product.price!)} vnd",
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            product.discount != 0
                                                ? Text(
                                                    "Giảm giá: ${product.discount}%",
                                                    style: GoogleFonts.aBeeZee(
                                                      fontSize: 17,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
