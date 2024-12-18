class EvaluationModel {
  late String? id;
  final String userId;
  final String fullname;
  final String productId;
  final String productOrderId;
  final String content;
  final bool incognito;
  final String sizeName;
  final String colorItemName;
  final String date;
  final String rate;
  late List<String>? images;
  late List<String>? like;

  EvaluationModel({
    this.id,
    required this.userId,
    required this.fullname,
    required this.productId,
    required this.productOrderId,
    required this.content,
    required this.incognito,
    required this.sizeName,
    required this.colorItemName,
    required this.date,
    required this.rate,
    this.images,
    this.like,
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      id: json['_id'],
      userId: json['userId'],
      fullname: json['fullname'],
      productId: json['productId'],
      productOrderId: json['productOrderId'],
      content: json['content'],
      incognito: json['incognito'],
      sizeName: json['sizeName'],
      colorItemName: json['colorItemName'],
      date: json['date'],
      rate: json['rate'],
      images: List<String>.from(json['images']),
      like: List<String>.from(json['like']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullname': fullname,
      'productId': productId,
      'productOrderId': productOrderId,
      'content': content,
      'incognito': incognito,
      'sizeName': sizeName,
      'colorItemName': colorItemName,
      'date': date,
      'rate': rate,
    };
  }
}
