import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

class TypeDetailModel {
  final String id;
  final String typeId;
  final String genderId;
  final String name;
  late String? description;

  TypeDetailModel({
    required this.id,
    required this.typeId,
    required this.genderId,
    required this.name,
    this.description,
  });

  static TypeDetailModel fromJson(Map<String, dynamic> json) {
    return TypeDetailModel(
      id: json['_id'],
      typeId: json['typeId'],
      genderId: json['genderId'],
      name: json['name'],
      description: json['description'] ?? "",
    );
  }
}
