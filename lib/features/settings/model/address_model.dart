class AddressModel {
  String? id;
  String? name;
  String? phone;
  String? house;
  String? area;
  String? city;
  String? state;
  String? pincode;

  AddressModel({
    this.id,
    this.name,
    this.phone,
    this.house,
    this.area,
    this.city,
    this.state,
    this.pincode,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
    house = json["house"];
    area = json["area"];
    city = json["city"];
    state = json["state"];
    pincode = json["pincode"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "house": house,
      "area": area,
      "city": city,
      "state": state,
      "pincode": pincode,
    };
  }
}