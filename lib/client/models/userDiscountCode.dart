class UserDiscountCodeModel {
  late String? id;
  late String? userId;
  late String? discountCodeId;
  late bool? used;

  UserDiscountCodeModel({
    this.id,
    this.userId,
    this.discountCodeId,
    this.used,
  });

  static UserDiscountCodeModel fromJson(Map<String, dynamic> json) {
    return UserDiscountCodeModel(
      id: json['_id'],
      userId: json['userId'],
      discountCodeId: json['discountCodeId'],
      used: json['used'],
    );
  }
}
