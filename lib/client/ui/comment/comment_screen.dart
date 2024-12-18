import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/manager/user_manager.dart';
import 'package:app_lv/client/models/evaluation_model.dart';
import 'package:app_lv/client/models/user_model.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/order/evaluation/star.dart';
import 'package:app_lv/client/ui/order/evaluation/star_rated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// trang hiển thị chi tiết các đánh giá
class CommentScreen extends StatefulWidget {
  final String productId;
  const CommentScreen({
    super.key,
    required this.productId,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserManager>().fetchAllUsers();
    // context.read<ProductManager>().fetchEvalsByProId(widget.productId);
    context.read<ProductManager>().rateEval(widget.productId);
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "ĐÁNH GIÁ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      // fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Consumer2<ProductManager, UserManager>(
                builder: (context, value, value2, child) {
                  if (value.evalsByProId.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.evalsByProId.length,
                      itemBuilder: (context, index) {
                        EvaluationModel eval = value.evalsByProId[index];
                        double rate = double.parse(eval.rate);
                        UserModel user = value2.allUser.firstWhere(
                            (element) => element.id! == eval.userId);
                        bool user1 = eval.like!
                            .contains(context.read<LoginService>().userId);
                        return Column(
                          children: [
                            index == 0
                                ? Row(
                                    children: [
                                      Text(
                                        "${value.rate}/5  ",
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        "(${value.evalsByProId.length} đánh giá)",
                                        style: GoogleFonts.abrilFatface(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            Row(
                              children: [
                                RatingDemo(rate: value.rate),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(0.15),
                                  1: FlexColumnWidth(0.65),
                                  2: FixedColumnWidth(0.2),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            eval.incognito == false
                                                ? user.image != null
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            Colors.black,
                                                        radius: 30,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "http://192.168.56.1:3005/${change(user.image)}",
                                                        ),
                                                      )
                                                    : const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.black,
                                                        radius: 30,
                                                      )
                                                : const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    radius: 30,
                                                  )
                                          ],
                                        ),
                                      ),
                                      TableCell(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            eval.incognito == false
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        user.username,
                                                        style:
                                                            GoogleFonts.aBeeZee(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              context
                                                                  .read<
                                                                      ProductManager>()
                                                                  .handleLike(
                                                                      widget
                                                                          .productId,
                                                                      context
                                                                          .read<
                                                                              LoginService>()
                                                                          .userId,
                                                                      eval.id!);
                                                            },
                                                            icon: user1 == true
                                                                ? const Icon(
                                                                    Icons
                                                                        .thumb_up_alt,
                                                                    color: Colors
                                                                        .blueAccent,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .thumb_up_alt_outlined,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "(Lượt thích ${eval.like!.length})",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Không tên",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              context
                                                                  .read<
                                                                      ProductManager>()
                                                                  .handleLike(
                                                                      widget
                                                                          .productId,
                                                                      context
                                                                          .read<
                                                                              LoginService>()
                                                                          .userId,
                                                                      eval.id!);
                                                            },
                                                            icon: user1 == true
                                                                ? const Icon(
                                                                    Icons
                                                                        .thumb_up_alt,
                                                                    color: Colors
                                                                        .blueAccent,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .thumb_up_alt_outlined,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "(Lượt thích ${eval.like!.length})",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                            RatingDemo(
                                              rate: rate,
                                            ),
                                            Text(
                                              "Phân loại: ${eval.colorItemName}, ${eval.sizeName}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              "Nội dung: ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                      255, 69, 69, 69)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      eval.content,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              child: ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: eval.images!.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 3),
                                                    child: Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                      child: Image.network(
                                                        "http://192.168.56.1:3005/${change(eval.images![index])}",
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              eval.date,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 17,
                                                color: Color.fromARGB(
                                                    255, 99, 99, 99),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const TableCell(
                                        child: Column(
                                          children: [],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: Color.fromARGB(255, 135, 135, 135),
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Sản phẩm chưa có bình luận nào",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
