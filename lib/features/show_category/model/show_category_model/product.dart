class Product {
  int? id;
  String? name;
  String? description;
  int? stock;
  String? price;
  int? bestSeller;
  int? discount;
  double? priceAfterDiscount;
  String? image;

  Product({
    this.id,
    this.name,
    this.description,
    this.stock,
    this.price,
    this.bestSeller,
    this.discount,
    this.priceAfterDiscount,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      stock: json['stock'] as int?,
      price: json['price'] as String?,
      bestSeller: json['best_seller'] as int?,
      discount: json['discount'] as int?,
      priceAfterDiscount: (json['price_after_discount'] as num?)?.toDouble(),
      image: json['image'] as String?,
    );
  }
}
