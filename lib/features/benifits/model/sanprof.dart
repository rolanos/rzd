class Sanprof {
  String? name;
  String? address;
  Categories? categories;
  bool? medLicense;

  Sanprof({
    required this.name,
    required this.address,
    required this.categories,
    required this.medLicense,
  });

  factory Sanprof.fromJson(Map<String, dynamic> json) => Sanprof(
        name: json["name"] as String?,
        address: json["address"] as String?,
        categories: json["categories"] != null
            ? Categories.fromJson(json["categories"])
            : null,
        medLicense: json["med_license"] as bool?,
      );
}

class Categories {
  String? lux;
  String? comf;
  String? comfDbl;
  String? standartDbl;
  String? standartFour;
  String? standartSngl;
  String? standartTrpl;

  Categories({
    required this.lux,
    required this.comf,
    required this.comfDbl,
    required this.standartDbl,
    required this.standartFour,
    required this.standartSngl,
    required this.standartTrpl,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        lux: json["lux"] as String?,
        comf: json["comf"] as String?,
        comfDbl: json["comf dbl"] as String?,
        standartDbl: json["standart dbl"] as String?,
        standartFour: json["standart four"] as String?,
        standartSngl: json["standart sngl"] as String?,
        standartTrpl: json["standart trpl"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "lux": lux,
        "comf": comf,
        "comf dbl": comfDbl,
        "standart dbl": standartDbl,
        "standart four": standartFour,
        "standart sngl": standartSngl,
        "standart trpl": standartTrpl,
      };
}
