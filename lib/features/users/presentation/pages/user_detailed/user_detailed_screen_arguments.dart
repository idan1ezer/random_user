import '../../../domain/entities/user.dart';

class UserDetailedScreenArguments {
  final UserEntity user;
  final List<UserEntity> users;

  UserDetailedScreenArguments(this.user, this.users);
}