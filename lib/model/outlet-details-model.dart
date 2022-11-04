import 'dart:convert';

OutletDetailsResponse outletDetailsResponseFromJson(String str) =>
    OutletDetailsResponse.fromJson(json.decode(str));

String outletDetailsResponseToJson(OutletDetailsResponse data) =>
    json.encode(data.toJson());

class OutletDetailsResponse {
  OutletDetailsResponse({
    this.message,
    this.outlets,
    this.status,
  });

  String? message;
  Outlets? outlets;
  bool? status;

  factory OutletDetailsResponse.fromJson(Map<String, dynamic> json) =>
      OutletDetailsResponse(
        message: json["message"],
        outlets:
            json["outlet"] != null ? Outlets.fromJson(json["outlet"]) : null,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "outlet": outlets!.toJson(),
        "status": status,
      };
}

class Outlets {
  Outlets({
    this.address,
    this.adminId,
    this.created,
    this.deleted,
    this.id,
    this.images,
    this.latitude,
    this.longitude,
    this.name,
    this.outletid,
    this.phoneNumber,
    this.restaurantid,
    this.status,
    this.subadminId,
    this.updated,
  });

  String? address;
  String? adminId;
  String? created;
  bool? deleted;
  int? id;
  List<String>? images;
  String? latitude;
  String? longitude;
  String? name;
  String? outletid;
  String? phoneNumber;
  String? restaurantid;
  bool? status;
  String? subadminId;
  String? updated;

  factory Outlets.fromJson(Map<String, dynamic> json) => Outlets(
        address: json["address"],
        adminId: json["admin_id"],
        created: json["created"],
        deleted: json["deleted"],
        id: json["id"],
        images: json.containsKey('images')
            ? json['images'] != null
                ? List<String>.from(json["images"].map((x) => x))
                : []
            : null,
        latitude: json["latitude"],
        longitude: json["longitude"],
        name: json["name"],
        outletid: json["outlet_id"],
        phoneNumber: json["phone_number"],
        restaurantid: json["restaurant_id"],
        status: json["status"],
        subadminId: json["sub_admin_id"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "admin_id": adminId,
        "created": created,
        "deleted": deleted,
        "id": id,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "latitude": latitude,
        "longitude": longitude,
        "name": name,
        "outlet_id": outletid,
        "restaurant_id": restaurantid,
        "phone_number": phoneNumber,
        "status": status,
        "sub_admin_id": subadminId,
        "updated": updated,
      };
}
