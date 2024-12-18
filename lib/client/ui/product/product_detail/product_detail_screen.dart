import 'package:app_lv/client/manager/favroite_manager.dart';
import 'package:app_lv/client/manager/viewedProduct_manager.dart';
import 'package:app_lv/client/models/product_model.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/comment/comment_screen.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/ui/shared/product_screen.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:input_quantity/input_quantity.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id; // id sản phẩm
  const ProductDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final SocketService socketService = SocketService();
  late bool _seclectedFavorite;

  late var _selectedSize = 0;
  late var _selectedColor = 0;

  int selectedColorIndex = 0;
  int selectedSizeIndex = 0;
  String userId = "";

  int quantity = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedSize = 0;
      _selectedColor = 0;
      _seclectedFavorite = false;
    });
    socketService.connect();
    context.read<ProductManager>().fetchProductById(widget.id);
    userId = context.read<LoginService>().userId;

    _initialize();

    socketService.on('deleteOneOrder', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('deleteOneOrder: $data');
        await context.read<ProductManager>().fetchProductById(widget.id);
      }
    });

    socketService.on('createOrder', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('deleteOneOrder: $data');
        await context.read<ProductManager>().fetchProductById(widget.id);
      }
    });

    socketService.on('updateProduct', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('updateProduct: $data');
        await context.read<ProductManager>().fetchProductById(widget.id);
      }
    });

    socketService.on('orderStatus', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('deleteOneOrder: $data');
        await context.read<ProductManager>().fetchProductById(widget.id);
      }
    });
  }

  Future<void> _initialize() async {
    await context
        .read<ViewedProductManager>()
        .create(context.read<LoginService>().userId, widget.id);
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  Future<void> addProduct(String userId, String productId, String colorItemId,
      String sizeId, int quantity, int? quantityInStock) async {
    try {
      bool result = await context.read<ProductManager>().createCart(
          context.read<LoginService>().userId,
          productId,
          colorItemId,
          sizeId,
          quantity.toInt(),
          quantityInStock!);
      if (result == false) {
        await showErrorDialog(context, "Số lượng vượt quá số lượng trong kho!");
      } else {
        await toast(context, "Thêm sản phẩm thành công");
      }
    } catch (error) {
      if (mounted) {
        print("Đã xảy ra lỗi: $error");
        await showErrorDialog(context, "Thêm không thành công!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Tên sản phẩm"),
        // centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        actions: [
          Consumer<FavoriteManager>(
            builder: (context, value, child) {
              if (value.favorites.isNotEmpty &&
                  value.isNotEmpty(userId, widget.id) == true) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      value.deleteOne(userId, widget.id);
                    },
                    icon: const Icon(Icons.favorite, color: Colors.pink),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      value.create(userId, widget.id);
                    },
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.black,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProductManager>(
              builder: (context, value, child) {
                if (value.productDetails.isNotEmpty) {
                  ProductModel product = value.productDetails[0];
                  ColorItem colorItem =
                      value.productDetails[0].colors![selectedColorIndex];
                  Size size = colorItem.sizes![selectedSizeIndex];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, top: 0, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250, // Set height of the container
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: colorItem.images!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      "http://192.168.56.1:3005/${change(colorItem.images![index])}",
                                    ),
                                    fit: BoxFit
                                        .fitHeight, // Ensures the image's height fits within the container
                                    width:
                                        200, // You can adjust width if necessary
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "${product.name!} (Màu${colorItem.name!})",
                            style: GoogleFonts.roboto(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        product.discount! != 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Giá Gốc: ${NumberFormat('#,##0', 'vi_VN').format(colorItem.price!)} vnd",
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    "Giá Sale: ${NumberFormat('#,##0', 'vi_VN').format((colorItem.price! - (colorItem.price! * product.discount! / 100)))} vnd",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(255, 0, 34, 136),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "Giá: ${NumberFormat('#,##0', 'vi_VN').format(colorItem.price!)} vnd",
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Màu",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 15.0,
                          runSpacing: 10.0,
                          children: List<Widget>.generate(
                            product.colors!.length,
                            (index) {
                              return SizedBox(
                                height: 40,
                                width: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedColorIndex = index;
                                      selectedSizeIndex = 0;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                      color: selectedColorIndex == index
                                          ? Colors.black
                                          : Color.fromARGB(255, 122, 119, 119),
                                      width: _selectedColor == index ? 3 : 1,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    backgroundColor: hexToColor(
                                        product.colors![index].color!),
                                  ),
                                  child: const Center(
                                    child: SizedBox.shrink(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 43, 43, 43),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Size",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Hướng Dẫn Size",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Wrap(
                            spacing: 15.0,
                            runSpacing: 10.0,
                            children: List<Widget>.generate(
                              colorItem.sizes!.length,
                              (index) {
                                return SizedBox(
                                  height: 45,
                                  width: 80,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedSizeIndex = index;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        color: selectedSizeIndex == index
                                            ? Colors.black
                                            : const Color.fromARGB(
                                                255, 74, 74, 74),
                                        width:
                                            selectedSizeIndex == index ? 2 : 1,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    child: Text(
                                      colorItem.sizes![index].name!,
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 17,
                                        color: selectedSizeIndex == index
                                            ? Colors.blue
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              const Text(
                                "Kho: ",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              size.quantity! == 0
                                  ? Row(
                                      children: [
                                        Text(
                                          "Sản phẩm hết hàng ",
                                          style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      size.quantity.toString(),
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 20,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 43, 43, 43),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Số lượng: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity--;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove)),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity >= 1) {
                                    quantity++;
                                  }
                                  if (quantity > size.quantity!) {
                                    showErrorDialog(context,
                                        "Só lượng vượt quá số lượng trong kho");
                                    quantity = quantity - 1;
                                  }
                                });
                              },
                              icon: const Icon(Icons.add),
                            )
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10),
                        //   child: ElevatedButton(
                        //     onPressed: () {},
                        //     style: ElevatedButton.styleFrom(
                        //       shape: const RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.zero,
                        //       ),
                        //       side: const BorderSide(
                        //         color: Colors.black,
                        //       ),
                        //       backgroundColor:
                        //           const Color.fromARGB(255, 255, 255, 255),
                        //     ),
                        //     child: const Padding(
                        //       padding: EdgeInsets.only(
                        //         left: 5,
                        //         right: 5,
                        //         top: 8,
                        //         bottom: 8,
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             "MUA NGAY",
                        //             style: TextStyle(
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.bold,
                        //               color: Color.fromARGB(255, 0, 0, 0),
                        //             ),
                        //           ),
                        //           Icon(
                        //             Icons.arrow_forward_ios,
                        //             color: Color.fromARGB(255, 0, 0, 0),
                        //             size: 25,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                                top: 8,
                                bottom: 8,
                              ),
                              child: size.quantity! != 0
                                  ? GestureDetector(
                                      onTap: () {
                                        addProduct(
                                            widget.id,
                                            product.id!,
                                            colorItem.id!,
                                            size.id!,
                                            quantity,
                                            size.quantity!);
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "THÊM VÀO GIỎ HÀNG",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.shopping_bag_outlined,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {},
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "HẾT HÀNG",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.do_not_disturb_alt,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 43, 43, 43),
                        ),
                        const DescriptionScreen(),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 12),
                          child: CommentScreen(
                            productId: widget.id,
                          ),
                        ),
                        const ProductScreen(),
                        const QuestionScreen(),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                        "Có lỗi trong quá trình hiển thị chi tiết sản phẩm"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 2),
          child: Row(
            children: [
              Text(
                'CÂU HỎI?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.question_answer_outlined,
                    size: 40,
                  ),
                  const Text(
                    "Chat với cửa hàng",
                    style: TextStyle(fontSize: 17),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: const Text(
                      "BẮT ĐẦU NGAY",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.help_outline,
                    size: 40,
                  ),
                  const Text(
                    "Nhờ sự giúp đỡ",
                    style: TextStyle(fontSize: 17),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: const Text(
                      "FAQ & HELP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10, left: 8, right: 8),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'MÔ TẢ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Sản phẩm đẹp chất lượng, vải được làm từ 200 cotton",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
