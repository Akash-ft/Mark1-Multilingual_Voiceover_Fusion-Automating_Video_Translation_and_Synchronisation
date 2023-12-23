import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    required this.message,
    required this.status,
  });

  String message;
  bool status;

  ErrorModel copyWith({
    String? message,
    bool? status,
  }) =>
      ErrorModel(
        message: message ?? this.message,
        status: status ?? this.status,
      );

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["Message"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Status": status,
      };
}
