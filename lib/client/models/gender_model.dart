import 'package:flutter/material.dart';

class GenderModel {
  final String id;
  final String name;
  final String description;

  GenderModel({
    required this.id,
    required this.name,
    required this.description,
  });

  static GenderModel fromJson(Map<String, dynamic> json) {
    return GenderModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
