import 'dart:convert';

BookSlotsResponse bookSlotsResponseFromJson(String str) =>
    BookSlotsResponse.fromJson(json.decode(str));

String bookSlotsResponseToJson(BookSlotsResponse data) =>
    json.encode(data.toJson());

class BookSlotsResponse {
  BookSlotsResponse({
    this.booking,
    this.message,
    this.status,
  });

  Booking? booking;
  String? message;
  bool? status;

  factory BookSlotsResponse.fromJson(Map<String, dynamic> json) =>
      BookSlotsResponse(
        booking: Booking.fromJson(json["booking"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "booking": booking!.toJson(),
        "message": message,
        "status": status,
      };
}

class Booking {
  Booking({
    this.bookingId,
    this.currentWaitTime,
    this.outletName,
    this.outletPhoneNumber,
    this.partySize,
    this.slotTime,
    this.slotdateTime,
  });

  String? bookingId;
  String? currentWaitTime;
  String? outletName;
  String? outletPhoneNumber;
  String? partySize;
  String? slotTime;
  String? slotdateTime;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json["booking_id"],
        currentWaitTime: json["current_wait_time"],
        outletName: json["outlet_name"],
        outletPhoneNumber: json["outlet_phone_number"],
        partySize: json["party_size"],
        slotTime: json["slot_time"],
        slotdateTime:json["slot_date_time"]
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "current_wait_time": currentWaitTime,
        "outlet_name": outletName,
        "outlet_phone_number": outletPhoneNumber,
        "party_size": partySize,
        "slot_time": slotTime,
        "slot_date_time":slotdateTime
      };
}
