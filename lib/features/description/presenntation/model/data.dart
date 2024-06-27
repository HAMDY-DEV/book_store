class Data {
  int? id;
  String? name;
  String? description;
  int? stock;
  int? bestSeller;
  String? price;
  int? discount;
  double? priceAfterDiscount;
  String? image;
  String? category;

  Data({
    this.id,
    this.name,
    this.description,
    this.stock,
    this.bestSeller,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.image,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      stock: json['stock'] as int?,
      bestSeller: json['best_seller'] as int?,
      price: json['price'] as String?,
      discount: json['discount'] as int?,
      priceAfterDiscount: (json['price_after_discount'] as num?)?.toDouble(),
      image: json['image'] as String?,
      category: json['category'] as String?,
    );
  }
}
