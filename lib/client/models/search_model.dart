class SearchModel {
  final String id;
  final String userId;
  final String searchName;

  SearchModel({
    required this.id,
    required this.userId,
    required this.searchName,
  });

  static SearchModel fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['_id'],
      userId: json['userId'],
      searchName: json['searchName'],
    );
  }
}
