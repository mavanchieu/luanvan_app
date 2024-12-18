class OrderModel {
  final String id;
  final String userId;
  final String fullname;
  final String email;
  final String phone;
  final String address;
  final String status;
  final String date;
  final int totalPrice;
  final String? fromDate;
  final String? toDate;
  final String? userDiscountCodeId;
  final String? code;
  final String? discount;
  final List<Product> products;
  final String paymentMethod;

  OrderModel({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
    required this.date,
    required this.totalPrice,
    this.fromDate,
    this.toDate,
    this.userDiscountCodeId,
    this.code,
    this.discount,
    required this.products,
    required this.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      userId: json['userId'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      status: json['status'],
      date: json['date'],
      totalPrice: int.parse(json['totalPrice']),
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      userDiscountCodeId: json['userDiscountCodeId'],
      code: json['code'],
      discount: json['discount'],
      products: (json['products'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      paymentMethod: json['paymentMethod'],
    );
  }
}

class Product {
  late final String productId;
  late final String productName;
  late final String colorItemId;
  late final String colorItemName;
  late final String sizeId;
  late final String sizeName;
  late final int quantity;
  late final int price;
  late final String image;
  late final int discount;
  late final String id;
  Product({
    required this.productId,
    required this.productName,
    required this.colorItemId,
    required this.colorItemName,
    required this.sizeId,
    required this.sizeName,
    required this.quantity,
    required this.price,
    required this.image,
    required this.discount,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      productName: json['productName'],
      colorItemId: json['colorItemId'],
      colorItemName: json['colorItemName'],
      sizeId: json['sizeId'],
      sizeName: json['sizeName'],
      quantity: json['quantity'],
      price: json['price'],
      image: json['image'],
      discount: json['discount'],
      id: json['_id'],
    );
  }
}
