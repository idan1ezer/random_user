import 'dart:io';

import 'package:action_item_project/core/resources/data_state.dart';
import 'package:action_item_project/features/users/domain/entities/user.dart';
import 'package:action_item_project/features/users/domain/repositories/user_repository.dart';

import 'package:dio/dio.dart';
import '../data_sources/remote/random_users_api_service.dart';
import '../data_sources/remote/users_api_service.dart';


class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final UsersRemoteDataSource _usersRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource, this._usersRemoteDataSource);

  @override
  Future<DataState<List<UserEntity>>> getUsers(int? num) async {
    try {
      final data = await _userRemoteDataSource.getTenUsers(
          10
      );

      return DataSuccess(data);

    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<UserEntity>>> getUsersOLD(int? num) async {
    try {
      final httpResponse = await _usersRemoteDataSource.getTenUsers(
        num: num,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }


}