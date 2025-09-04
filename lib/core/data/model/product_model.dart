 class Product {
  final String? sId;
  final String? name;
  final int? stock;
  final String? description;
  final int? price;
  final String? categoryId;

  final List<String>? images;
  final List<String>? sizes;
  final List<String>? colors;
  final AgeRange? ageRange;
  final String? nameAr;
  final String? descriptionAr;
  final int? rating;
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
    return Product(
      sId: json['_id'],
      name: json['name'],
      stock: json['stock'],
      description: json['description'],
      price: json['price'],
      categoryId: json['categoryId'],
      images: (json['images'] as List?)?.cast<String>(),
      sizes: (json['sizes'] as List?)?.cast<String>(),
      colors: (json['colors'] as List?)?.cast<String>(),
      ageRange: json['ageRange'] != null ? AgeRange.fromJson(json['ageRange']) : null,
      nameAr: json['nameAr'],
      descriptionAr: json['descriptionAr'],
      rating: json['rating'],
      reviewsCount: json['reviewsCount'],
      favoritesCount: json['favoritesCount'],
      viewsCount: json['viewsCount'],
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


	AgeRange(

  );

	AgeRange.fromJson(Map<String, dynamic> json) {
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		return data;
	}
}
