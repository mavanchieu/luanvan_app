import 'package:flutter/foundation.dart';

class HelpModel {
  final String id;
  final String userId; // id người gửi
  final String fullname;
  final String phone;
  final String email;
  final String question;
  final Reply reply;

  HelpModel({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.question,
    required this.reply,
  });

  factory HelpModel.fromJson(Map<String, dynamic> json) {
    return HelpModel(
      id: json['_id'],
      userId: json['userId'],
      fullname: json['fullname'],
      phone: json['phone'],
      email: json['email'],
      question: json['question'],
      reply: Reply.fromJson(json['reply']),
    );
  }
}

class Reply {
  final String userIdReply;
  final String answer;

  Reply({
    required this.userIdReply,
    required this.answer,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      userIdReply: json['userIdReply'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}
