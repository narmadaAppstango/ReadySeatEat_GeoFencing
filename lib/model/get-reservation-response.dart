import 'dart:convert';

import 'package:http/http.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/api-constants.dart';

GetReservationsResponse getReservationsResponseFromJson(String str) =>
    GetReservationsResponse.fromJson(json.decode(str));

String getReservationsResponseToJson(GetReservationsResponse data) =>
    json.encode(data.toJson());

class GetReservationsResponse {
  GetReservationsResponse({
    this.getReservations,
    this.message,
    this.status,
  });

  List<GetReservations>? getReservations;
  String? message;
  bool? status;

  factory GetReservationsResponse.fromJson(Map<String, dynamic> json) =>
      GetReservationsResponse(
        getReservations: json.containsKey('booking')
            ? json['booking'] != null
                ? List<GetReservations>.from(
                    json["booking"].map((x) => GetReservations.fromJson(x)))
                : []
            : null,
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "booking": List<dynamic>.from(getReservations!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class GetReservations {
  GetReservations({
    this.bookingId,
    this.currentWaitTime,
    this.originalBookingId,
    this.outletName,
    this.slotdatetime
  });

  String? bookingId;
  String? currentWaitTime;
  String? originalBookingId;
  String? outletName;
  String? slotdatetime;

  factory GetReservations.fromJson(Map<String, dynamic> json) =>
      GetReservations(
        bookingId: json["booking_id"],
        currentWaitTime: json["current_wait_time"],
        originalBookingId: json["original_booking_id"],
        outletName: json["outlet_name"],
        slotdatetime: json["slot_date_time"]
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "current_wait_time": currentWaitTime,
        "original_booking_id": originalBookingId,
        "outlet_name": outletName,
        "slot_date_time":slotdatetime
      };
}
