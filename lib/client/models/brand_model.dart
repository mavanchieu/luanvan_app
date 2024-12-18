class BrandModel {
  final String id;
  final String name;
  final String description;

  BrandModel({
    required this.id,
    required this.name,
    required this.description,
  });

  static BrandModel fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
