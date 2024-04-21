import 'package:action_item_project/features/users/domain/entities/user.dart';

class UserModel extends UserEntity {

  final Login? login;
  final Dob? registered;
  final Id? id;

  const UserModel({
    required String? gender,
    required Name? name,
    required Location? location,
    required String? email,
    required Dob? dob,
    required String? phone,
    required String? cell,
    required Picture? picture,
    required String? nat,
    this.login,
    this.registered,
    this.id,
  }) : super(
    gender: gender,
    name: name,
    location: location,
    email: email,
    dob: dob,
    phone: phone,
    cell: cell,
    picture: picture,
    nat: nat
  );


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['gender'],
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      email: json['email'],
      dob: json['dob'] != null ? Dob.fromJson(json['dob']) : null,
      phone: json['phone'],
      cell: json['cell'],
      picture: json['picture'] != null ? Picture.fromJson(json['picture']) : null,
      login: json['login'] != null ? Login.fromJson(json['login']) : null,
      registered: json['registered'] != null
          ? Dob.fromJson(json['registered'])
          : null,
      id: json['id'] != null ? Id.fromJson(json['id']) : null,
      nat: json['nat'],
    );
  }

  UserEntity toEntity() => UserEntity(
    gender: gender,
    name: name,
    location: location,
    email: email,
    dob: dob,
    phone: phone,
    cell: cell,
    picture: picture,
    nat: nat,
  );

}



class Login {
  String uuid;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  Login({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      uuid: json['uuid'],
      username: json['username'],
      password: json['password'],
      salt: json['salt'],
      md5: json['md5'],
      sha1: json['sha1'],
      sha256: json['sha256'],
    );
  }
}



class Id {
  String name;
  String? value;

  Id({
    required this.name,
    required this.value,
  });

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      name: json['name'],
      value: json['value'] ?? "",
    );
  }
}