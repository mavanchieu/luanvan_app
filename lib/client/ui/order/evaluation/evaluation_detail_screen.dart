import 'dart:convert';
import 'dart:io';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/models/evaluation_model.dart';
import 'package:app_lv/client/models/order_model.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/order/evaluation/star.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EvaluationDetailScreen extends StatefulWidget {
  final Product product;
  final String productOrderId;
  final String sizeName;
  final String colorItemName;
  final String fullname;
  const EvaluationDetailScreen({
    super.key,
    required this.product,
    required this.productOrderId,
    required this.sizeName,
    required this.colorItemName,
    required this.fullname,
  });

  @override
  State<EvaluationDetailScreen> createState() => _EvaluationDetailScreenState();
}

class _EvaluationDetailScreenState extends State<EvaluationDetailScreen> {
  bool _selected = false;
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _content = TextEditingController();
  double _rating = 5.0;

  @override
  void initState() {
    super.initState();
  }

  void _onRatingChanged(double rating) {
    setState(() {
      _rating = rating;
    });
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  List<File> imageFiles = []; // List to store selected images
  List<String> imageDataList = []; // List to store base64-encoded image data

  choiceImages() async {
    var pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        imageFiles = pickedImages.map((img) => File(img.path)).toList();
        imageDataList = imageFiles
            .map((file) => base64Encode(file.readAsBytesSync()))
            .toList();
      });
    }
  }

// Display a single image
  showImage(String image) {
    return Image.memory(
      base64Decode(image),
      width: 100,
      height: 120,
    );
  }

// Display all selected images
  showImages() {
    return Wrap(
      children: imageDataList
          .map((image) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: showImage(image),
              ))
          .toList(),
    );
  }

  Future<bool> _submit(
    String userId,
    bool incognito,
    String content,
    double rating,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    try {
      bool result = await context.read<ProductManager>().addToRate(
            userId,
            widget.productOrderId,
            widget.product.productId,
            incognito,
            content,
            rating,
            widget.sizeName,
            widget.colorItemName,
            widget.fullname,
            imageFiles,
          );
      if (result == true) {
        await toast(context, "Bạn đã đánh giá thành công");
        return true;
      } else {
        await showErrorDialog(context, "Đánh giá sản phẩm không thành công");
      }
    } catch (e) {
      if (mounted) {
        await showErrorDialog(
            context, "Có lỗi trong quá trình bình luận sản phẩm");
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Viết đánh giá",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
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
                              color: Color.fromARGB(255, 223, 222, 222),
                            ),
                            children: [
                              TableCell(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        'http://192.168.56.1:3005/orders/${change(
                                          widget.product.image,
                                        )}',
                                        width: 200,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.product.price} vnd",
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Màu: ${widget.product.colorItemName}",
                                          ),
                                        ],
                                      ),
                                      Text("Size: ${widget.product.sizeName}"),
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
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StarRating(
                    starCount: 5,
                    rating: _rating,
                    onRatingChanged: _onRatingChanged,
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đánh giá sản phẩm này.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Viết đánh giá",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _content,
                      decoration: const InputDecoration(
                        hintText: "Bạn nghĩ như thế nào về sản phẩm này?",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      maxLines: 3,
                      maxLength: 300,
                    ),
                    const Text(
                      "Thêm ảnh",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    showImages(),
                    SizedBox(
                      width: 115,
                      child: ElevatedButton(
                        onPressed: choiceImages,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Chọn ảnh',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _selected = !_selected;
                          });
                        },
                        child: _selected == false
                            ? Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    "Đánh giá ẩn danh",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    "Đánh giá ẩn danh",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              )),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_selected == true) {}
                          bool result = await _submit(
                              context.read<LoginService>().userId,
                              _selected,
                              _content.text,
                              _rating);
                          if (result == true) {
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          "Gửi",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
