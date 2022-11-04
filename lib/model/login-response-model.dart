import 'dart:convert';

LoginResponseModel loginModelResponseFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginModelResponseToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.message,
    this.status,
    this.token,
    this.value,
  });

  String? message;
  bool? status;
  String? token;
  Value? value;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        status: json["status"],
        token: json["token"],
        value: json["value"] != null ? Value.fromJson(json["value"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "token": token,
        "value": value!.toJson(),
      };
}

class Value {
  Value({
    this.cognitoUserId,
    this.created,
    this.createdBy,
    this.deleted,
    this.email,
    this.firstName,
    this.id,
    this.isEmailValid,
    this.lastName,
    this.middleName,
    this.phoneNumber,
    this.profilecreated,
    this.profilePicture,
    this.status,
    this.updated,
    this.username,
  });

  String? cognitoUserId;
  String? created;
  String? createdBy;
  bool? deleted;
  String? email;
  String? firstName;
  int? id;
  bool? isEmailValid;
  String? lastName;
  String? middleName;
  String? phoneNumber;
  bool? profilecreated;
  String? profilePicture;
  bool? status;
  String? updated;
  String? username;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        cognitoUserId: json["cognito_user_id"],
        created: json["created"],
        createdBy: json["createdBy"],
        deleted: json["deleted"],
        email: json["email"],
        firstName: json["firstName"],
        id: json["id"],
        isEmailValid: json["isEmailValid"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        phoneNumber: json["phone_number"],
        profilecreated: json["profileCreated"],
        profilePicture: json["profilePicture"],
        status: json["status"],
        updated: json["updated"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "cognito_user_id": cognitoUserId,
        "created": created,
        "createdBy": createdBy,
        "deleted": deleted,
        "email": email,
        "firstName": firstName,
        "id": id,
        "isEmailValid": isEmailValid,
        "lastName": lastName,
        "middleName": middleName,
        "phone_number": phoneNumber,
        "profileCreated":profilecreated,
        "profilePicture": profilePicture,
        "status": status,
        "updated": updated,
        "username": username,
      };
}
