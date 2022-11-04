import 'dart:convert';

OutLetSearchResponse outletSearchResponseFromJson(String str) =>
    OutLetSearchResponse.fromJson(json.decode(str));

String outLetSearchesponseeToJson(OutLetSearchResponse data) =>
    json.encode(data.toJson());

class OutLetSearchResponse {
  OutLetSearchResponse({
    this.message,
    this.status,
    this.outletsNames,
  });

  String? message;
  bool? status;
  List<OutletsNames>? outletsNames;

  factory OutLetSearchResponse.fromJson(Map<String, dynamic> json) =>
      OutLetSearchResponse(
        message: json["message"],
        status: json["status"],
        outletsNames: json.containsKey('outlets')
            ? json['outlets'] != null
                ? List<OutletsNames>.from(
                    json["outlets"].map((x) => OutletsNames.fromJson(x)))
                : []
            : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "outlets": List<dynamic>.from(outletsNames!.map((x) => x.toJson())),
      };
}

class OutletsNames {
  OutletsNames({
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

  factory OutletsNames.fromJson(Map<String, dynamic> json) => OutletsNames(
        address: json["address"],
        adminId: json["admin_id"],
        created: json["created"],
        deleted: json["deleted"],
        id: json["id"],
        images: json.containsKey('images')
            ? json['images'] != null
                ?  List<String>.from(json["images"].map((x) => x))
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
         "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "latitude":latitude,
        "longitude":longitude,
        "name": name,
        "outlet_id": outletid,
        "restaurant_id": restaurantid,
        "phone_number": phoneNumber,
        "status": status,
        "sub_admin_id": subadminId,
        "updated": updated,
      };
}
