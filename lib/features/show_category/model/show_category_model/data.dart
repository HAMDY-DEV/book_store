import 'product.dart';

class Data {
  int? id;
  String? name;
  String? slug;
  List<Product>? products;

  Data({this.id, this.name, this.slug, this.products});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
