import 'dart:convert';

GetPreviousReservationsResponse getPreviousReservationsResponseFromJson(
        String str) =>
    GetPreviousReservationsResponse.fromJson(json.decode(str));

String getPreviousReservationsResponseToJson(
        GetPreviousReservationsResponse data) =>
    json.encode(data.toJson());

class GetPreviousReservationsResponse {
  GetPreviousReservationsResponse({
    this.appUserDetails,
    this.booking,
    this.message,
    this.status,
  });

  AppUserDetails? appUserDetails;
  Booking? booking;
  String? message;
  bool? status;

  factory GetPreviousReservationsResponse.fromJson(Map<String, dynamic> json) =>
      GetPreviousReservationsResponse(
        appUserDetails: AppUserDetails.fromJson(json["app_user_details"]),
        booking: Booking.fromJson(json["booking"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "app_user_details": appUserDetails!.toJson(),
        "booking": booking!.toJson(),
        "message": message,
        "status": status,
      };
}

class AppUserDetails {
  AppUserDetails({
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

  factory AppUserDetails.fromJson(Map<String, dynamic> json) => AppUserDetails(
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

class Booking {
  Booking(
      {this.bookingId,
      this.currentWaitTime,
      this.noOfSeats,
      this.originalBookingId,
      this.outletName,
      this.outletPhoneNumber,
      this.slotDate,
      this.slotId,
      this.slotTime,
      this.slotdatetime,
      this.outletid,
      this.userverified});

  String? bookingId;
  String? currentWaitTime;
  String? noOfSeats;
  String? originalBookingId;
  String? outletName;
  String? outletPhoneNumber;
  String? slotDate;
  String? slotId;
  String? slotTime;
  String? outletid;
  String? slotdatetime;
  bool? userverified;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
      bookingId: json["booking_id"],
      currentWaitTime: json["current_wait_time"],
      noOfSeats: json["no_of_seats"],
      originalBookingId: json["original_booking_id"],
      outletName: json["outlet_name"],
      outletPhoneNumber: json["outlet_phone_number"],
      slotDate: json["slot_date"],
      slotId: json["slot_id"],
      slotTime: json["slot_time"],
      slotdatetime: json["slot_date_time"],
      outletid: json["outlet_id"],
      userverified: json["user_already_verified"]
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "current_wait_time": currentWaitTime,
        "no_of_seats": noOfSeats,
        "original_booking_id": originalBookingId,
        "outlet_name": outletName,
        "outlet_phone_number": outletPhoneNumber,
        "slot_date": slotDate,
        "slot_id": slotId,
        "slot_time": slotTime,
        "slot_date_time": slotdatetime,
        "outlet_id": outletid,
        "user_already_verified":userverified
      };
}
