import 'dart:convert';

ResetPasswordResponseDataModel resetPasswordResponseDataModelFromJson(
        String str) =>
    ResetPasswordResponseDataModel.fromJson(json.decode(str));

String ResetPasswordResponseDataModelToJson(
        ResetPasswordResponseDataModel data) =>
    json.encode(data.toJson());

class ResetPasswordResponseDataModel {
  ResetPasswordResponseDataModel({this.message, this.status, this.response});

  String? message;
  bool? status;
  Response? response;

  factory ResetPasswordResponseDataModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponseDataModel(
        message: json["message"],
        status: json["status"],
        response:json["response"] != null ? Response.fromJson(json["response"]):null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "response": response!.toJson(),
      };
}

class Response {
  Response({
    this.message,
    this.status,
  });

  String? message;
  bool? status;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
