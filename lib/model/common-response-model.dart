import 'dart:convert';

CommonResponseDataModel commonResponseDataModelFromJson(String str) =>
    CommonResponseDataModel.fromJson(json.decode(str));

String commonResponseDataModelToJson(CommonResponseDataModel data) =>
    json.encode(data.toJson());

class CommonResponseDataModel {
  CommonResponseDataModel({
    this.message,
    this.status,
  });

  String? message;
  bool? status;

  factory CommonResponseDataModel.fromJson(Map<String, dynamic> json) =>
      CommonResponseDataModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
