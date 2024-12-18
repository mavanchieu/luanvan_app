import 'package:app_lv/client/manager/discountCodes_manager.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/manager/userDiscountCode.dart';
import 'package:app_lv/client/models/cart_model.dart';
import 'package:app_lv/client/models/discountCodes.model.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/cart/cart_screen.dart';
import 'package:app_lv/client/ui/payment/process_screen.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController _fullname = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  String? _selectedPaymentMethod;
  int discount1 = 0;
  String code = "";
  String userDiscountCodeId = "";
  DiscountCodesModel? selectedDiscount;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _fetchProducts();
    await _fetchCarts();
    await _fetchDiscountCode();
    await _fetchUserDiscountCode();
  }

  Future<void> _fetchProducts() async {
    try {
      await context.read<ProductManager>().fetchProduct();
    } catch (e) {
      print('Lỗi khi lấy sản phẩm: $e');
    }
  }

  Future<void> _fetchCarts() async {
    try {
      final userId = context.read<LoginService>().userId;
      await context.read<ProductManager>().fetchCarts(userId);
    } catch (e) {
      print('Lỗi khi lấy giỏ hàng: $e');
    }
  }

  Future<void> _fetchDiscountCode() async {
    try {
      await context.read<DiscountcodesManager>().fetchDiscountCodes();
    } catch (e) {
      print('Lỗi khi lấy giỏ hàng: $e');
    }
  }

  Future<void> _fetchUserDiscountCode() async {
    try {
      final userId = context.read<LoginService>().userId;
      await context
          .read<UserDiscountCodeManager>()
          .fetchUserDiscountCodeByUserId(userId);
    } catch (e) {
      print('Lỗi khi lấy giỏ hàng: $e');
    }
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  bool showSummary = false;

  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thanh toán",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tóm tắt",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "${NumberFormat('#,##0', 'vi_VN').format(context.read<ProductManager>().totalPrice())} vnd",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showSummary = !showSummary;
                          });
                        },
                        child: showSummary == false
                            ? const Icon(
                                Icons.expand_more_outlined,
                              )
                            : const Icon(
                                Icons.expand_less,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            showSummary == true
                ? Consumer<ProductManager>(
                    builder: (context, value, child) {
                      if (value.carts.isNotEmpty) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.carts.length,
                          itemBuilder: (context, index) {
                            String productId = value.carts[index].productId;
                            String colorItemId = value.carts[index].colorItemId;
                            String sizeId = value.carts[index].sizeId;
                            var product = value.products.firstWhere(
                                (element) => element.id == productId);
                            var color = product.colors!.firstWhere(
                                (element) => element.id! == colorItemId);
                            var size = color.sizes!
                                .firstWhere((element) => element.id! == sizeId);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(0.4),
                                  1: FlexColumnWidth(0.6),
                                  // 2: FlexColumnWidth(0.1),
                                },
                                children: [
                                  TableRow(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 222, 220, 220),
                                    ),
                                    children: [
                                      TableCell(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                "http://192.168.56.1:3005/${change(color.images![0])}",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name!,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "${NumberFormat('#,##0', 'vi_VN').format(color.price!)} vnd",
                                                    style: GoogleFonts.aBeeZee(
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Phân loại: ",
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                  Text(
                                                    "${color.name!}, ${size.name!}",
                                                    style: GoogleFonts.aBeeZee(
                                                        fontSize: 17),
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
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                  Text(
                                                    "x${value.carts[index].quantity}",
                                                    style: GoogleFonts.aBeeZee(
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
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${product.discount}%",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox.shrink(),
                                              const Divider(
                                                thickness: 0.5,
                                                color: Colors.black,
                                              ),
                                              const Text(
                                                "Tạm tính ",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  "${NumberFormat('#,##0', 'vi_VN').format(value.carts[index].quantity * (color.price! - (color.price! * product.discount! / 100)))} vnd",
                                                  style: GoogleFonts.aBeeZee(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.pink,
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
                          },
                        );
                      } else {
                        return const NotCart();
                      }
                    },
                  )
                : const SizedBox.shrink(),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 146, 146, 146),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Điền tên và địa chỉ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _fullname,
                      decoration: const InputDecoration(
                        labelText: "Họ và tên",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 126, 225),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: _address,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Địa chỉ",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 126, 225),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Thông tin liên hệ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _phone,
                      decoration: const InputDecoration(
                        labelText: "Số điện thoại",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 126, 225),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 126, 225),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 10),
              child: Column(
                children: [
                  const Text(
                    "Bạn có khuyến mãi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer2<UserDiscountCodeManager, DiscountcodesManager>(
                    builder: (context, value, value2, child) {
                      final totalPrice =
                          context.read<ProductManager>().totalPrice();

                      // Lọc danh sách mã khuyến mãi hợp lệ
                      var validDiscounts =
                          value2.discountCodes.where((discount) {
                        return value.userDiscountCodesByUserId
                            .any((userDiscount) {
                          return userDiscount.discountCodeId == discount.id &&
                              !userDiscount.used! &&
                              totalPrice >= discount.price;
                        });
                      }).toList();

                      return validDiscounts.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: validDiscounts.map((discount) {
                                // Get the valid user discount for this discount code
                                var validUserDiscount =
                                    value.userDiscountCodesByUserId.firstWhere(
                                  (user) => user.discountCodeId == discount.id,
                                );

                                return RadioListTile<DiscountCodesModel>(
                                  activeColor: Colors.blue,
                                  title: Text(
                                    'Giảm ${discount.discount}% cho đơn hàng từ ${discount.price}',
                                    style: TextStyle(
                                      color: selectedDiscount == discount
                                          ? Colors.blue // Color when selected
                                          : Colors.black, // Default color
                                    ),
                                  ),
                                  value:
                                      discount, // Use the discount object as value
                                  groupValue:
                                      selectedDiscount, // Use selectedDiscount for groupValue
                                  onChanged: (DiscountCodesModel? newValue) {
                                    setState(() {
                                      selectedDiscount = newValue;
                                      discount1 = newValue!.discount;
                                      userDiscountCodeId =
                                          validUserDiscount.id!;
                                      code = newValue.code!;
                                    });
                                    if (newValue != null) {
                                      print(
                                          'Selected Discount Code: ${newValue.code}');
                                    }
                                  },
                                );
                              }).toList(),
                            )
                          : const Text(
                              "Không có mã khuyến mãi nào hợp lệ.",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hình thức thanh toán",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RadioListTile<String>(
                    title: const Text('Tiền mặt'),
                    value: 'Tiền mặt',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Zalo Pay'),
                    value: 'Zalo Pay',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: value,
                        onChanged: (value) {
                          setState(
                            () {
                              this.value = value!;
                            },
                          );
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "Tôi đồng ý với các điều khoản của cửa hàng,",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool result =
                            await context.read<ProductManager>().addOrder(
                                  _fullname.text,
                                  _address.text,
                                  _phone.text,
                                  _email.text,
                                  _selectedPaymentMethod!,
                                  context.read<LoginService>().userId,
                                  discount1,
                                  userDiscountCodeId,
                                  code,
                                );
                        if (result == true) {
                          toast(context, "Bạn đã đặt hàng thành công");
                          Navigator.of(context).pop();
                        } else {
                          toastError(context,
                              "Số lượng sản phẩm mua không phù hợp, vui lòng kiểm tra lại");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Đặt Hàng",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 143, 143, 143),
              ),
            ),
            // const Process(),
          ],
        ),
      ),
    );
  }
}
