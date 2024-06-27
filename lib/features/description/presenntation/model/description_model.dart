import 'package:book_store/features/description/presenntation/model/data.dart';

class DescriptionModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  DescriptionModel({this.data, this.message, this.error, this.status});

  factory DescriptionModel.fromJson(Map<String, dynamic> json) {
    return DescriptionModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }
}
