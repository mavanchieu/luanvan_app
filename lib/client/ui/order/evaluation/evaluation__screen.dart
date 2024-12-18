import 'dart:convert';
import 'dart:io';

import 'package:app_lv/client/manager/Evaluation_manager.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/order/evaluation/evaluation_detail_screen.dart';
import 'package:app_lv/client/ui/order/not_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({super.key});

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  final SocketService socketService = SocketService();
  @override
  void initState() {
    super.initState();
    socketService.connect();

    context
        .read<ProductManager>()
        .fetchOrders(context.read<LoginService>().userId);
    context
        .read<ProductManager>()
        .fetchEvalutions(context.read<LoginService>().userId);
    socketService.on('confirmShipping', (data) async {
      if (mounted) {
        print('confirmShipping: $data');
        await context
            .read<ProductManager>()
            .fetchOrders(context.read<LoginService>().userId);
        await context
            .read<ProductManager>()
            .fetchEvalutions(context.read<LoginService>().userId);
      }
    });
    socketService.on('createEvaluation', (data) async {
      if (mounted) {
        print('createEvaluation: $data');
        await context
            .read<ProductManager>()
            .fetchOrders(context.read<LoginService>().userId);
        await context
            .read<ProductManager>()
            .fetchEvalutions(context.read<LoginService>().userId);
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
              if (value.evals.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.evals.length,
                    itemBuilder: (context, index) {
                      final order = value.evals[index];
                      return Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Đã nhận hàng',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: order.products.length,
                            itemBuilder: (context, productIndex) {
                              final product = order.products[productIndex];
                              bool isEvaluated = value.evalsByUserId.any(
                                  (eval) => eval.productOrderId == product.id);
                              // print(value2.evalsByUserId[0].productOrderId);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  children: [
                                    Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(0.4),
                                        1: FlexColumnWidth(0.5),
                                        2: FlexColumnWidth(0.1),
                                      },
                                      children: [
                                        TableRow(
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
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
                                                      'http://192.168.56.1:3005/orders/${change(product.image)}',
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
                                                      children: [
                                                        Text(
                                                          "${product.price} vnd",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 40,
                                                        ),
                                                        Text(
                                                          "x${product.quantity}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      product.productName,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          product.colorItemName,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                        Text(
                                                          ", ${product.sizeName}",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          width: 150,
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  const RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero,
                                                              ),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              side:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              "Mua lại",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          width: 150,
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                isEvaluated
                                                                    ? null
                                                                    : () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                EvaluationDetailScreen(
                                                                              product: product,
                                                                              productOrderId: product.id,
                                                                              sizeName: product.sizeName,
                                                                              colorItemName: product.colorItemName,
                                                                              fullname: order.fullname,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  const RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero,
                                                              ),
                                                              backgroundColor:
                                                                  isEvaluated
                                                                      ? Colors
                                                                          .grey
                                                                      : const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          214,
                                                                          14,
                                                                          117),
                                                            ),
                                                            child: Text(
                                                              isEvaluated
                                                                  ? "Đã đánh giá"
                                                                  : "Đánh giá",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return const NotPaymentScreen();
              }
            },
          )
        ],
      ),
    );
  }
}
