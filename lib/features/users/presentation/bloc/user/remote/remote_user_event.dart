import '../../../../domain/entities/user.dart';

abstract class RemoteUserEvent {
  final UserEntity? user;
  const RemoteUserEvent({this.user});
}

class GetUsers extends RemoteUserEvent {
  const GetUsers();
}

class UserFilterChanged extends RemoteUserEvent {
  final String? country;
  final String? name;
  final List<UserEntity> users;

  UserFilterChanged(this.country, this.name, this.users);
}

class UserNameUpdated extends RemoteUserEvent {
  final String newName;
  final String oldName;
  final List<UserEntity> users;

  UserNameUpdated(this.newName, this.oldName, this.users);
}

