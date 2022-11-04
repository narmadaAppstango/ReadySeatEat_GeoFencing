import 'dart:convert';

ForgetPasswordResponseModel forgetPasswordResponseModelFromJson(String str) => ForgetPasswordResponseModel.fromJson(json.decode(str));

String forgetPasswordResponseModelToJson(ForgetPasswordResponseModel data) => json.encode(data.toJson());

class ForgetPasswordResponseModel {
    ForgetPasswordResponseModel({
        this.message,
        this.status,
    });

    String? message;
    bool? status;

    factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) => ForgetPasswordResponseModel(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
