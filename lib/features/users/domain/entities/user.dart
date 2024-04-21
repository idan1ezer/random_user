import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? gender;
  final Name? name;
  final Location? location;
  final String? email;
  final Dob? dob;
  final String? phone;
  final String? cell;
  final Picture? picture;
  final String? nat;

  const UserEntity({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.dob,
    this.phone,
    this.cell,
    this.picture,
    this.nat,
  });

  @override
  List<Object?> get props {
    return [
      gender,
      name,
      location,
      email,
      dob,
      phone,
      cell,
      picture,
      nat,
    ];
  }
}

class Dob {
  String date;
  int age;

  Dob({
    required this.date,
    required this.age,
  });

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(
      date: json['date'],
      age: json['age'],
    );
  }
}

class Location {
  Street? street;
  String city;
  String state;
  String country;
  String postcode;
  Coordinates? coordinates;
  Timezone? timezone;

  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: json['street'] != null ? Street.fromJson(json['street']) : null,
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'].toString(),
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      timezone: json['timezone'] != null
          ? Timezone.fromJson(json['timezone'])
          : null,
    );
  }
}

class Coordinates {
  String latitude;
  String longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Street {
  int number;
  String name;

  Street({
    required this.number,
    required this.name,
  });

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      number: json['number'],
      name: json['name'],
    );
  }
}

class Timezone {
  String offset;
  String description;

  Timezone({
    required this.offset,
    required this.description,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      offset: json['offset'],
      description: json['description'],
    );
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class Picture {
  String large;
  String medium;
  String thumbnail;

  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}