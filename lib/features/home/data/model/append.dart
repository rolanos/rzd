class Append {
  final String id;
  final String name;

  factory Append.fromJson(String key, String value) =>
      Append(id: key, name: value);

  Append({required this.id, required this.name});
}
