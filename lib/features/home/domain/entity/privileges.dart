class Privileges {
  final String id;
  final String description;
  final String image;

  Privileges({
    required this.id,
    required this.description,
    this.image = '',
  });

  Privileges copyWith({String? id, String? description, String? image}) {
    return Privileges(
      id: id ?? this.id,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
