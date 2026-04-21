class ProductModel {
  final String id;
  final String? productName;
  final String? image;
  final dynamic price;
  final String? priceUnit;
  final String? companyName;
  final String? companyLogo;
  final String? city;
  final String? state;
  final String? description;
  final String? role;
  final bool? verified;
  final dynamic rating;
  final String? createdBy;

  ProductModel({
    required this.id,
    this.productName,
    this.image,
    this.price,
    this.priceUnit,
    this.companyName,
    this.companyLogo,
    this.city,
    this.state,
    this.description,
    this.role,
    this.verified,
    this.rating,
    this.createdBy,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var createdByData = json['createdBy'];
    String? cName;
    String? cLogo;
    String? cId;

    if (createdByData is Map) {
      cName = createdByData['companyName'] ?? createdByData['fullName'];
      cLogo = createdByData['companyLogo'] ?? createdByData['profilePic'];
      cId = createdByData['_id'];
    }

    return ProductModel(
      id: json['_id'] ?? json['id'] ?? '',
      productName: json['productName'] ?? json['title'] ?? json['name'] ?? '',
      image: json['image'] ?? json['img'] ?? (json['images'] != null && json['images'].isNotEmpty ? json['images'][0] : null),
      price: json['price'],
      priceUnit: json['priceUnit'] ?? 'Unit',
      companyName: cName ?? json['companyName'] ?? 'Company',
      companyLogo: cLogo ?? json['companyLogo'],
      city: json['city'] ?? (json['location'] != null ? json['location']['city'] : null),
      state: json['state'] ?? (json['location'] != null ? json['location']['state'] : null),
      description: json['description'] ?? json['interestedIn'] ?? '',
      role: json['role'],
      verified: json['verified'] ?? true,
      rating: json['rating'] ?? 4.5,
      createdBy: cId,
    );
  }
}
