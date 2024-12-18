class Message {
  final String content;
  final String status;

  Message({required this.content, required this.status});

  // Tạo từ JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] as String,
      status: json['status'] as String,
    );
  }

  // Chuyển sang JSON
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'status': status,
    };
  }
}

class ChatModel {
  final String id;
  final String userId;
  final List<Message> messages;

  ChatModel({required this.id, required this.userId, required this.messages});

  // Tạo từ JSON
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      messages: (json['message'] as List)
          .map((msg) => Message.fromJson(msg as Map<String, dynamic>))
          .toList(),
    );
  }

  // Chuyển sang JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'message': messages.map((msg) => msg.toJson()).toList(),
    };
  }
}
