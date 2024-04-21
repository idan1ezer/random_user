

import '../../../domain/entities/user.dart';

abstract class UserRemoteDataSource {

  Future<List<UserEntity>> getTenUsers(int? num);

}
