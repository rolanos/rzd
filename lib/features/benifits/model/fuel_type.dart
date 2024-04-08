class FuelType {
  final Map<String, String>? fuel;
  final String? name;

  FuelType({
    this.fuel,
    this.name,
  });

  factory FuelType.fromJson(Map<String, dynamic> json) => FuelType(
        fuel: Map.from(json["fuel"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "fuel": Map.from(fuel!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "name": name,
      };
}
