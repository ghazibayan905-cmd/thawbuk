class Product {
	String? sId;
	String? name;
	int? stock;
	String? description;
	int? price;
	String? categoryId;
	List<String>? images;
	List<String>? sizes;
	List<String>? colors;
	AgeRange? ageRange;
	String? nameAr;
	String? descriptionAr;
	int? rating;
	int? reviewsCount;
	int? favoritesCount;
	int? viewsCount;

	Product({this.sId, this.name, this.stock, this.description, this.price, this.categoryId, this.images, this.sizes, this.colors, this.ageRange, this.nameAr, this.descriptionAr, this.rating, this.reviewsCount, this.favoritesCount, this.viewsCount});

	Product.fromJson(Map<String, dynamic> json) {
		sId = json['_id'];
		name = json['name'];
		stock = json['stock'];
		description = json['description'];
		price = json['price'];
		categoryId = json['categoryId'];
		images = json['images'].cast<String>();
		sizes = json['sizes'].cast<String>();
		colors = json['colors'].cast<String>();
		ageRange = json['ageRange'] != null ? new AgeRange.fromJson(json['ageRange']) : null;
		nameAr = json['nameAr'];
		descriptionAr = json['descriptionAr'];
		rating = json['rating'];
		reviewsCount = json['reviewsCount'];
		favoritesCount = json['favoritesCount'];
		viewsCount = json['viewsCount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = this.sId;
		data['name'] = this.name;
		data['stock'] = this.stock;
		data['description'] = this.description;
		data['price'] = this.price;
		data['categoryId'] = this.categoryId;
		data['images'] = this.images;
		data['sizes'] = this.sizes;
		data['colors'] = this.colors;
		if (this.ageRange != null) {
      data['ageRange'] = this.ageRange!.toJson();
    }
		data['nameAr'] = this.nameAr;
		data['descriptionAr'] = this.descriptionAr;
		data['rating'] = this.rating;
		data['reviewsCount'] = this.reviewsCount;
		data['favoritesCount'] = this.favoritesCount;
		data['viewsCount'] = this.viewsCount;
		return data;
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
