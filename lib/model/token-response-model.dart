// To parse this JSON data, do
//
//     final tokenResponse = tokenResponseFromJson(jsonString);

import 'dart:convert';

TokenResponse tokenResponseFromJson(String str) =>
    TokenResponse.fromJson(json.decode(str));

String tokenResponseToJson(TokenResponse data) => json.encode(data.toJson());

class TokenResponse {
  TokenResponse({
    this.deviceToken,
    this.message,
    this.status,
  });

  DeviceToken? deviceToken;
  String? message;
  bool? status;

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
        deviceToken: json["device_token"] == null || json["device_token"] == ''
            ? null
            : DeviceToken.fromJson(json["device_token"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "device_token": deviceToken!.toJson(),
        "message": message,
        "status": status,
      };
}

class DeviceToken {
  DeviceToken({
    this.appEndpoint,
    this.appUserId,
    this.created,
    this.deleted,
    this.deviceToken,
    this.deviceType,
    this.enablePushNoti,
    this.id,
    this.status,
    this.updated,
  });

  String? appEndpoint;
  String? appUserId;
  String? created;
  bool? deleted;
  String? deviceToken;
  String? deviceType;
  bool? enablePushNoti;
  int? id;
  bool? status;
  String? updated;

  factory DeviceToken.fromJson(Map<String, dynamic> json) => DeviceToken(
        appEndpoint: json["app_endpoint"],
        appUserId: json["app_user_id"],
        created: json["created"],
        deleted: json["deleted"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        enablePushNoti: json["enable_push_noti"],
        id: json["id"],
        status: json["status"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "app_endpoint": appEndpoint,
        "app_user_id": appUserId,
        "created": created,
        "deleted": deleted,
        "device_token": deviceToken,
        "device_type": deviceType,
        "enable_push_noti": enablePushNoti,
        "id": id,
        "status": status,
        "updated": updated,
      };
}
