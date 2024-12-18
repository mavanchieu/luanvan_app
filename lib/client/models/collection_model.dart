class CollectionModel {
  late String? id;
  late String? brandId;
  late String? collectionName;
  late String? description;
  late List<String>? images;
  late List<String>? productIds;

  CollectionModel({
    this.id,
    this.brandId,
    this.collectionName,
    this.description,
    this.images,
    this.productIds,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['_id'],
      brandId: json['brandId'],
      collectionName: json['collectionName'],
      description: json['description'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      productIds: json['productIds'] != null
          ? List<String>.from(json['productIds'])
          : null,
    );
  }
}
