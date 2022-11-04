// To parse this JSON data, do
//
//     final slotReservationResponse = slotReservationResponseFromJson(jsonString);

import 'dart:convert';

SlotReservationResponse slotReservationResponseFromJson(String str) =>
    SlotReservationResponse.fromJson(json.decode(str));

String slotReservationResponseToJson(SlotReservationResponse data) =>
    json.encode(data.toJson());

class SlotReservationResponse {
  SlotReservationResponse({
    this.message,
    this.slots,
    this.status,
  });

  String? message;
  List<Slot>? slots;
  bool? status;

  factory SlotReservationResponse.fromJson(Map<String, dynamic> json) =>
      SlotReservationResponse(
        message: json["message"],
        slots: json.containsKey('slots')
            ? json['slots'] != null
                ? List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x)))
                : []
            : null,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "slots": List<dynamic>.from(slots!.map((x) => x.toJson())),
        "status": status,
      };
}

class Slot {
  Slot({
    this.noOfSeats,
    this.slotAvailable,
    this.slotEndTime,
    this.slotId,
    this.slotStartTime,
    this.selected,
  });

  String? noOfSeats;
  bool? slotAvailable;
  String? slotEndTime;
  String? slotId;
  String? slotStartTime;
  bool? selected;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        noOfSeats: json["no_of_seats"],
        slotAvailable: json["slot_available"],
        slotEndTime: json["slot_end_time"],
        slotId: json["slot_id"],
        slotStartTime: json["slot_start_time"],
      );

  Map<String, dynamic> toJson() => {
        "no_of_seats": noOfSeats,
        "slot_available": slotAvailable,
        "slot_end_time": slotEndTime,
        "slot_id": slotId,
        "slot_start_time": slotStartTime,
      };
}
