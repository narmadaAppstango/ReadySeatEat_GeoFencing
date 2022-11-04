import 'dart:convert';

EmailVerificationResponseModel emailVerificationResponseModelFromJson(
        String str) =>
    EmailVerificationResponseModel.fromJson(json.decode(str));

String emailVerificationResponseModelToJson(
        EmailVerificationResponseModel data) =>
    json.encode(data.toJson());

class EmailVerificationResponseModel {
  EmailVerificationResponseModel({
    this.message,
    this.response,
    this.status,
  });

  String? message;
  Response? response;
  bool? status;

  factory EmailVerificationResponseModel.fromJson(Map<String, dynamic> json) =>
      EmailVerificationResponseModel(
        message: json["message"],
        response: json.containsKey('response')
            ? Response.fromJson(json["response"])
            : null,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response": response!.toJson(),
        "status": status,
      };
}

class Response {
  Response({
    this.responseMetadata,
  });

  ResponseMetadata? responseMetadata;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        responseMetadata: ResponseMetadata.fromJson(json["ResponseMetadata"]),
      );

  Map<String, dynamic> toJson() => {
        "ResponseMetadata": responseMetadata!.toJson(),
      };
}

class ResponseMetadata {
  ResponseMetadata({
    this.httpHeaders,
    this.httpStatusCode,
    this.requestId,
    this.retryAttempts,
  });

  HttpHeaders? httpHeaders;
  int? httpStatusCode;
  String? requestId;
  int? retryAttempts;

  factory ResponseMetadata.fromJson(Map<String, dynamic> json) =>
      ResponseMetadata(
        httpHeaders: HttpHeaders.fromJson(json["HTTPHeaders"]),
        httpStatusCode: json["HTTPStatusCode"],
        requestId: json["RequestId"],
        retryAttempts: json["RetryAttempts"],
      );

  Map<String, dynamic> toJson() => {
        "HTTPHeaders": httpHeaders!.toJson(),
        "HTTPStatusCode": httpStatusCode,
        "RequestId": requestId,
        "RetryAttempts": retryAttempts,
      };
}

class HttpHeaders {
  HttpHeaders({
    this.connection,
    this.contentLength,
    this.contentType,
    this.date,
    this.xAmznRequestid,
  });

  String? connection;
  String? contentLength;
  String? contentType;
  String? date;
  String? xAmznRequestid;

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
