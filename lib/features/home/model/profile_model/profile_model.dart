import 'data.dart';

class ProfileModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  ProfileModel({this.data, this.message, this.error, this.status});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }
}
