import 'data.dart';

class ShowCategoryModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  ShowCategoryModel({this.data, this.message, this.error, this.status});

  factory ShowCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShowCategoryModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }
}
