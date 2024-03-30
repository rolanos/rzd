// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FuelForm {
  final bool delivery;
  final bool wall;
  final int fuel_type;
  final int person_count;
  final int area;
  final bool cooking;
  final bool water;
  final int year;
  final String address;

  final String? mobile_phone;
  final String? home_phone;
  final String? email;
  final String? comment;
  //??
  final String? filename;
  FuelForm({
    required this.delivery,
    required this.wall,
    required this.fuel_type,
    required this.person_count,
    required this.area,
    required this.cooking,
    required this.water,
    required this.year,
    required this.address,
    this.mobile_phone,
    this.home_phone,
    this.email,
    this.comment,
    this.filename,
  });

  FuelForm copyWith({
    bool? delivery,
    bool? wall,
    int? fuel_type,
    int? person_count,
    int? area,
    bool? cooking,
    bool? water,
    int? year,
    String? address,
    String? mobile_phone,
    String? home_phone,
    String? email,
    String? comment,
    String? filename,
  }) {
    return FuelForm(
      delivery: delivery ?? this.delivery,
      wall: wall ?? this.wall,
      fuel_type: fuel_type ?? this.fuel_type,
      person_count: person_count ?? this.person_count,
      area: area ?? this.area,
      cooking: cooking ?? this.cooking,
      water: water ?? this.water,
      year: year ?? this.year,
      address: address ?? this.address,
      mobile_phone: mobile_phone ?? this.mobile_phone,
      home_phone: home_phone ?? this.home_phone,
      email: email ?? this.email,
      comment: comment ?? this.comment,
      filename: filename ?? this.filename,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'delivery': delivery,
      'wall': wall,
      'fuel_type': fuel_type,
      'person_count': person_count,
      'area': area,
      'cooking': cooking,
      'water': water,
      'year': year,
      'address': address,
      'mobile_phone': mobile_phone,
      'home_phone': home_phone,
      'email': email,
      'comment': comment,
      'filename': filename,
    };
  }

  factory FuelForm.fromMap(Map<String, dynamic> map) {
    return FuelForm(
      delivery: map['delivery'] as bool,
      wall: map['wall'] as bool,
      fuel_type: map['fuel_type'] as int,
      person_count: map['person_count'] as int,
      area: map['area'] as int,
      cooking: map['cooking'] as bool,
      water: map['water'] as bool,
      year: map['year'] as int,
      address: map['address'] as String,
      mobile_phone:
          map['mobile_phone'] != null ? map['mobile_phone'] as String : null,
      home_phone:
          map['home_phone'] != null ? map['home_phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      filename: map['filename'] != null ? map['filename'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelForm.fromJson(String source) =>
      FuelForm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FuelForm(delivery: $delivery, wall: $wall, fuel_type: $fuel_type, person_count: $person_count, area: $area, cooking: $cooking, water: $water, year: $year, address: $address, mobile_phone: $mobile_phone, home_phone: $home_phone, email: $email, comment: $comment, filename: $filename)';
  }

  @override
  bool operator ==(covariant FuelForm other) {
    if (identical(this, other)) return true;

    return other.delivery == delivery &&
        other.wall == wall &&
        other.fuel_type == fuel_type &&
        other.person_count == person_count &&
        other.area == area &&
        other.cooking == cooking &&
        other.water == water &&
        other.year == year &&
        other.address == address &&
        other.mobile_phone == mobile_phone &&
        other.home_phone == home_phone &&
        other.email == email &&
        other.comment == comment &&
        other.filename == filename;
  }

  @override
  int get hashCode {
    return delivery.hashCode ^
        wall.hashCode ^
        fuel_type.hashCode ^
        person_count.hashCode ^
        area.hashCode ^
        cooking.hashCode ^
        water.hashCode ^
        year.hashCode ^
        address.hashCode ^
        mobile_phone.hashCode ^
        home_phone.hashCode ^
        email.hashCode ^
        comment.hashCode ^
        filename.hashCode;
  }
}
