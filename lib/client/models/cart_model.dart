class CartModel {
  final String id;
  final String productId;

  final String colorItemId;

  final String sizeId;

  final String userId;
  int quantity;

  CartModel({
    required this.id,
    required this.productId,
    required this.colorItemId,
    required this.sizeId,
    required this.userId,
    required this.quantity,
  });

  static CartModel fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      productId: json['productId'],
      colorItemId: json['colorItemId'],
      sizeId: json['sizeId'],
      userId: json['userId'],
      quantity: json['quantity'],
    );
  }
}
