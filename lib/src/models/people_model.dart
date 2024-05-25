// ignore_for_file: non_constant_identifier_names

class CastModel {
  final num gender;
  final num id;
  final String known_for_department;
  final String name;
  final String original_name;
  final String? profile_path;
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

class PeopleModel {
  final num id;
  final bool adult;
  final String biography;
  final num gender;
  final String name;
  final String place_of_birth;
  final String birthday;
  final String? profile_path;

  PeopleModel({
    required this.id,
    required this.adult,
    required this.biography,
    required this.gender,
    required this.name,
    required this.place_of_birth,
    required this.birthday,
    required this.profile_path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adult': adult,
      'biography': biography,
      'gender': gender,
      'name': name,
      'place_of_birth': place_of_birth,
      'birthday': birthday,
      'profile_path': profile_path,
    };
  }

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      id: json['id'],
      adult: json['adult'],
      biography: json['biography'],
      gender: json['gender'],
      name: json['name'],
      place_of_birth: json['place_of_birth'],
      birthday: json['birthday'],
      profile_path: json['profile_path'],
    );
  }
}

class MovieCreditModel {
  final num id;
  final String? poster_path;
  final String title;
  final String original_title;
  final String credit_id;

  MovieCreditModel({
    required this.id,
    required this.poster_path,
    required this.title,
    required this.original_title,
    required this.credit_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_path': poster_path,
      'title': title,
      'original_title': original_title,
      'credit_id': credit_id,
    };
  }

  factory MovieCreditModel.fromJson(Map<String, dynamic> json) {
    return MovieCreditModel(
      id: json['id'],
      poster_path: json['poster_path'],
      title: json['title'],
      original_title: json['original_title'],
      credit_id: json['credit_id'],
    );
  }
}

class TVCreditModel {
  final num id;
  final String? poster_path;
  final String name;
  final String original_name;
  final String credit_id;

  TVCreditModel({
    required this.id,
    required this.poster_path,
    required this.name,
    required this.original_name,
    required this.credit_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_path': poster_path,
      'name': name,
      'original_name': original_name,
      'credit_id': credit_id,
    };
  }

  factory TVCreditModel.fromJson(Map<String, dynamic> json) {
    return TVCreditModel(
      id: json['id'],
      poster_path: json['poster_path'],
      name: json['name'],
      original_name: json['original_name'],
      credit_id: json['credit_id'],
    );
  }
}
