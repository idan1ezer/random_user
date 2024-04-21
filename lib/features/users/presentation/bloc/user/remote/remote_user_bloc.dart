import 'package:action_item_project/features/users/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:action_item_project/features/users/presentation/bloc/user/remote/remote_user_event.dart';
import 'package:action_item_project/features/users/presentation/bloc/user/remote/remote_user_state.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/get_users.dart';

class RemoteUserBloc extends Bloc<RemoteUserEvent, RemoteUserState> {
  final GetUsersUseCase _getUsersUseCase;

  RemoteUserBloc(this._getUsersUseCase) : super(const RemoteUserLoading()) {
    on <GetUsers> (onGetUsers);
    on <UserFilterChanged> (onUserFilterChanged);
    on <UserNameUpdated> (onUserNameUpdated);
  }

  void onGetUsers(GetUsers event, Emitter<RemoteUserState> emit) async{
    final dataState = await _getUsersUseCase.call();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
          RemoteUserDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      emit(
          RemoteUserException(dataState.exception!)
      );
    }
  }

  void onUserFilterChanged(UserFilterChanged event, Emitter<RemoteUserState> emit) async {
    List<UserEntity> tempFilteredList = [];
    if (event.country != null) {
      for (UserEntity user in event.users) {
        if (user.location!.country == event.country) {
          tempFilteredList.add(user);
        }
      }
      emit(RemoteUserFilterCountryDone(tempFilteredList));
    }
    else if (event.name != null) {
      for (UserEntity user in event.users) {
        if (user.name!.first == event.name) {
          tempFilteredList.add(user);
        }
      }
      emit(RemoteUserFilterCountryDone(tempFilteredList));
    }
    else {
      emit(
          RemoteUserDone(event.users)
      );
    }
    }

    void onUserNameUpdated(UserNameUpdated event, Emitter<RemoteUserState> emit) async {
    final newName = event.newName.split(' ');
    final oldName = event.oldName.split(' ');
    bool didUpdate = false;
    if (newName.length == 3) {
      for (UserEntity user in event.users) {

        if (user.name!.title == oldName[0] && user.name!.first == oldName[1] && user.name!.last == oldName[2]) {
          user.name!.title = newName[0];
          user.name!.first = newName[1];
          user.name!.last = newName[2];
          didUpdate = true;
          break;
        }
      }
    }

    if (didUpdate) {
      emit(
          RemoteUserNameUpdatedDone(event.users)
      );
    }
    else {
      emit(
          RemoteUserDone(event.users)
      );
    }
    }




}