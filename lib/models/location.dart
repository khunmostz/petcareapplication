class Location {
  late String locationId;
  late String locationName;
  late String locationDesc;
  late String locationLat;
  late String locationLong;
  late String locationImage;

  Location({
    required this.locationId,
    required this.locationName,
    required this.locationDesc,
    required this.locationLat,
    required this.locationLong,
    required this.locationImage,
  });

  Location.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    locationName = json['locationName'];
    locationDesc = json['locationDesc'];
    locationLat = json['locationLat'];
    locationLong = json['locationLong'];
    locationImage = json['locationImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    data['locationDesc'] = this.locationDesc;
    data['locationLat'] = this.locationLat;
    data['locationLong'] = this.locationLong;
    data['locationImage'] = this.locationImage;
    return data;
  }
}
