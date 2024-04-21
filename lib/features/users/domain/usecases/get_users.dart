
import 'package:action_item_project/features/users/domain/repositories/user_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';

class GetUsersUseCase implements UseCase<DataState<List<UserEntity>>, int> {
  final UserRepository _userRepository;
  GetUsersUseCase(this._userRepository);

  @override
  Future<DataState<List<UserEntity>>> call({int? params}) {
    return _userRepository.getUsers(params ?? 10);
  }

}