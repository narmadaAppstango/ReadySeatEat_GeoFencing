import 'dart:convert';

ResendSignupCodeResponse resendSignupCodeResponseFromJson(String str) =>
    ResendSignupCodeResponse.fromJson(json.decode(str));

String resendSignupCodeResponseToJson(ResendSignupCodeResponse data) =>
    json.encode(data.toJson());

class ResendSignupCodeResponse {
  ResendSignupCodeResponse({
    this.message,
    this.response,
    this.status,
  });

  String? message;
  Response? response;
  bool? status;

  factory ResendSignupCodeResponse.fromJson(Map<String, dynamic> json) =>
      ResendSignupCodeResponse(
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
    this.codeDeliveryDetails,
    this.responseMetadata,
  });

  CodeDeliveryDetails? codeDeliveryDetails;
  ResponseMetadata? responseMetadata;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        codeDeliveryDetails:
            CodeDeliveryDetails.fromJson(json["CodeDeliveryDetails"]),
        responseMetadata: ResponseMetadata.fromJson(json["ResponseMetadata"]),
      );

  Map<String, dynamic> toJson() => {
        "CodeDeliveryDetails": codeDeliveryDetails!.toJson(),
        "ResponseMetadata": responseMetadata!.toJson(),
      };
}

class CodeDeliveryDetails {
  CodeDeliveryDetails({
    this.attributeName,
    this.deliveryMedium,
    this.destination,
  });

  String? attributeName;
  String? deliveryMedium;
  String? destination;

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
