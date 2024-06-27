import 'data.dart';

class BooksData {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  BooksData({this.data, this.message, this.error, this.status});

  factory BooksData.fromJson(Map<String, dynamic> json) {
    return BooksData(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }
}
