class Privileges {
  final String id;
  final String description;
  final String svg;

  Privileges({
    required this.id,
    required this.description,
    this.svg = '',
  });

  Privileges copyWith({String? id, String? description, String? svg}) {
    return Privileges(
      id: id ?? this.id,
      description: description ?? this.description,
      svg: svg ?? this.svg,
    );
  }
}
