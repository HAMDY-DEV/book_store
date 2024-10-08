import 'data.dart';

class CategoriesModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CategoriesModel({this.data, this.message, this.error, this.status});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }
}
