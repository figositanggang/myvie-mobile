// ignore_for_file: non_constant_identifier_names

class CastModel {
  final num gender;
  final num id;
  final String known_for_department;
  final String name;
  final String original_name;
  final String profile_path;
  final String character;

  CastModel({
    required this.gender,
    required this.id,
    required this.known_for_department,
    required this.name,
    required this.original_name,
    required this.profile_path,
    required this.character,
  });

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'id': id,
      'known_for_department': known_for_department,
      'name': name,
      'original_name': original_name,
      'profile_path': profile_path,
      'character': character,
    };
  }

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      gender: json['gender'],
      id: json['id'],
      known_for_department: json['known_for_department'],
      name: json['name'],
      original_name: json['original_name'],
      profile_path: json['profile_path'],
      character: json['character'],
    );
  }
}
