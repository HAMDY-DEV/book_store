import 'data.dart';

class FavoriteModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  FavoriteModel({this.data, this.message, this.error, this.status});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }
}
