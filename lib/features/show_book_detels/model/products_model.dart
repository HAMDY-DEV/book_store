import 'data.dart';

class ProductsModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  ProductsModel({this.data, this.message, this.error, this.status});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }
}
