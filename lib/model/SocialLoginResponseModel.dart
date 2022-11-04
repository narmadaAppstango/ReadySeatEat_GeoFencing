import 'dart:convert';

SocialLoginResponse socialLoginResponseFromJson(String str) => SocialLoginResponse.fromJson(json.decode(str));

String socialLoginResponseToJson(SocialLoginResponse data) => json.encode(data.toJson());

class SocialLoginResponse {
    SocialLoginResponse({
        this.message,
        this.status,
        this.user,
    });

    String? message;
    bool? status;
    User? user;

    factory SocialLoginResponse.fromJson(Map<String, dynamic> json) => SocialLoginResponse(
        message: json["message"],
        status: json["status"],
        user:json["user"] != null ? User.fromJson(json["user"]):null,
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "user": user!.toJson(),
    };
}

class User {
    User({
        this.cognitoUserId,
        this.loginFrom,
        this.userDbDetails,
        this.userEmail,
    });

    String? cognitoUserId;
    String? loginFrom;
    UserDbDetails? userDbDetails;
    String? userEmail;

    factory User.fromJson(Map<String, dynamic> json) => User(
        cognitoUserId: json["cognito_user_id"],
        loginFrom: json["login_from"],
        userDbDetails: UserDbDetails.fromJson(json["user_db_details"]),
        userEmail: json["user_email"],
    );

    Map<String, dynamic> toJson() => {
        "cognito_user_id": cognitoUserId,
        "login_from": loginFrom,
        "user_db_details": userDbDetails!.toJson(),
        "user_email": userEmail,
    };
}

class UserDbDetails {
    UserDbDetails({
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
        this.profileCreated,
        this.profileCreationMode,
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
    bool? profileCreated;
    String? profileCreationMode;
    String? profilePicture;
    bool? status;
    String? updated;
    String? username;

    factory UserDbDetails.fromJson(Map<String, dynamic> json) => UserDbDetails(
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
        profileCreated: json["profileCreated"],
        profileCreationMode: json["profileCreationMode"],
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
        "profileCreated": profileCreated,
        "profileCreationMode": profileCreationMode,
        "profilePicture": profilePicture,
        "status": status,
        "updated": updated,
        "username": username,
    };
}
