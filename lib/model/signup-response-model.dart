import 'dart:convert';

SignupResponseModel signupResponseModelFromJson(String str) =>
    SignupResponseModel.fromJson(json.decode(str));

String signupResponseModelToJson(SignupResponseModel data) =>
    json.encode(data.toJson());

class SignupResponseModel {
  SignupResponseModel({this.data, this.status, this.message});

  Data? data;
  bool? status;
  String? message;

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupResponseModel(
        data: json.containsKey('data') ? Data.fromJson(json["data"]) : null,
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    required this.codeDeliveryDetails,
    required this.responseMetadata,
    required this.userConfirmed,
    required this.userSub,
  });

  CodeDeliveryDetails codeDeliveryDetails;
  ResponseMetadata responseMetadata;
  bool userConfirmed;
  String userSub;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        codeDeliveryDetails:
            CodeDeliveryDetails.fromJson(json["CodeDeliveryDetails"]),
        responseMetadata: ResponseMetadata.fromJson(json["ResponseMetadata"]),
        userConfirmed: json["UserConfirmed"],
        userSub: json["UserSub"],
      );

  Map<String, dynamic> toJson() => {
        "CodeDeliveryDetails": codeDeliveryDetails.toJson(),
        "ResponseMetadata": responseMetadata.toJson(),
        "UserConfirmed": userConfirmed,
        "UserSub": userSub,
      };
}

class CodeDeliveryDetails {
  CodeDeliveryDetails({
    required this.attributeName,
    required this.deliveryMedium,
    required this.destination,
  });

  String attributeName;
  String deliveryMedium;
  String destination;

  factory CodeDeliveryDetails.fromJson(Map<String, dynamic> json) =>
      CodeDeliveryDetails(
        attributeName: json["AttributeName"],
        deliveryMedium: json["DeliveryMedium"],
        destination: json["Destination"],
      );

  Map<String, dynamic> toJson() => {
        "AttributeName": attributeName,
        "DeliveryMedium": deliveryMedium,
        "Destination": destination,
      };
}

class ResponseMetadata {
  ResponseMetadata({
    required this.httpHeaders,
    required this.httpStatusCode,
    required this.requestId,
    required this.retryAttempts,
  });

  HttpHeaders httpHeaders;
  int httpStatusCode;
  String requestId;
  int retryAttempts;

  factory ResponseMetadata.fromJson(Map<String, dynamic> json) =>
      ResponseMetadata(
        httpHeaders: HttpHeaders.fromJson(json["HTTPHeaders"]),
        httpStatusCode: json["HTTPStatusCode"],
        requestId: json["RequestId"],
        retryAttempts: json["RetryAttempts"],
      );

  Map<String, dynamic> toJson() => {
        "HTTPHeaders": httpHeaders.toJson(),
        "HTTPStatusCode": httpStatusCode,
        "RequestId": requestId,
        "RetryAttempts": retryAttempts,
      };
}

class HttpHeaders {
  HttpHeaders({
    required this.connection,
    required this.contentLength,
    required this.contentType,
    required this.date,
    required this.xAmznRequestid,
  });

  String connection;
  String contentLength;
  String contentType;
  String date;
  String xAmznRequestid;

  factory HttpHeaders.fromJson(Map<String, dynamic> json) => HttpHeaders(
        connection: json["connection"],
        contentLength: json["content-length"],
        contentType: json["content-type"],
        date: json["date"],
        xAmznRequestid: json["x-amzn-requestid"],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "content-length": contentLength,
        "content-type": contentType,
        "date": date,
        "x-amzn-requestid": xAmznRequestid,
      };
}
