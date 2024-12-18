import 'package:flutter/material.dart';

class DiscountCodesModel {
  final String id;
  final String code;
  final String fromDate;
  final String toDate;
  final int discount;
  final String description;
  final int price;

  DiscountCodesModel({
    required this.id,
    required this.code,
    required this.fromDate,
    required this.toDate,
    required this.discount,
    required this.description,
    required this.price,
  });

  static DiscountCodesModel fromJson(Map<String, dynamic> json) {
    return DiscountCodesModel(
      id: json['_id'],
      code: json['code'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      discount: json['discount'],
      description: json['description'],
      price: json['price'],
    );
  }
}
