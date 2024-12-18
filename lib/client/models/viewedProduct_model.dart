class ViewedProductModel {
  final String id;
  final String userId;
  final String productId;

  ViewedProductModel({
    required this.id,
    required this.userId,
    required this.productId,
  });

  static ViewedProductModel fromJson(Map<String, dynamic> json) {
    return ViewedProductModel(
      id: json['_id'],
      userId: json['userId'],
      productId: json['productId'],
    );
  }
}
