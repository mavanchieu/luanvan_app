import 'package:flutter/material.dart';

class FavoriteModel {
  final String id;
  final String userId;
  final String productId;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.productId,
  });

  static FavoriteModel fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['_id'],
      userId: json['userId'],
      productId: json['productId'],
    );
  }
}
