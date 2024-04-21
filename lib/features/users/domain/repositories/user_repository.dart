
import '../../../../core/resources/data_state.dart';
import '../entities/user.dart';

abstract class UserRepository {

  // API methods
  Future<DataState<List<UserEntity>>> getUsers(int? num);
  Future<DataState<List<UserEntity>>> getUsersOLD(int? num);
}