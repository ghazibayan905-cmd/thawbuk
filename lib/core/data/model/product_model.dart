class Product {
  final String? sId;
  final String? name;
  final int? stock;
  final String? description;
  final double? price; // ⬅️ خليتها double
  final String? categoryId;

  final List<String>? images;
  final List<String>? sizes;
  final List<String>? colors;
  final AgeRange? ageRange;
  final String? nameAr;
  final String? descriptionAr;
  final double? rating; // ⬅️ خليتها double
  final int? reviewsCount;
  final int? favoritesCount;
  final int? viewsCount;

  Product({
    this.sId,
    this.name,
    this.stock,
    this.description,
    this.price,
    this.categoryId,
    this.images,
    this.sizes,
    this.colors,
    this.ageRange,
    this.nameAr,
    this.descriptionAr,
    this.rating,
    this.reviewsCount,
    this.favoritesCount,
    this.viewsCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double? parseToDouble(dynamic value) {
      if (value == null) return null;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return double.tryParse(value.toString());
    }

    return Product(
      sId: json['_id'],
      name: json['name'],
      stock: json['stock'] is int ? json['stock'] : int.tryParse(json['stock']?.toString() ?? '0'),
      description: json['description'],
      price: parseToDouble(json['price']),
      categoryId: json['categoryId'],
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      sizes: (json['sizes'] as List?)?.map((e) => e.toString()).toList(),
      colors: (json['colors'] as List?)?.map((e) => e.toString()).toList(),
      ageRange: json['ageRange'] != null ? AgeRange.fromJson(json['ageRange']) : null,
      nameAr: json['nameAr'],
      descriptionAr: json['descriptionAr'],
      rating: parseToDouble(json['rating']),
      reviewsCount: json['reviewsCount'] is int ? json['reviewsCount'] : int.tryParse(json['reviewsCount']?.toString() ?? '0'),
      favoritesCount: json['favoritesCount'] is int ? json['favoritesCount'] : int.tryParse(json['favoritesCount']?.toString() ?? '0'),
      viewsCount: json['viewsCount'] is int ? json['viewsCount'] : int.tryParse(json['viewsCount']?.toString() ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'stock': stock,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'images': images,
      'sizes': sizes,
      'colors': colors,
      if (ageRange != null) 'ageRange': ageRange!.toJson(),
      'nameAr': nameAr,
      'descriptionAr': descriptionAr,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'favoritesCount': favoritesCount,
      'viewsCount': viewsCount,
    };
  }
}

class AgeRange {
  AgeRange();

  AgeRange.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    return {};
  }
}
