class GenreModel {
  final num id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  factory GenreModel.fromMap(Map<String, dynamic> map) => GenreModel(
        id: map['id'],
        name: map['name'],
      );
}
