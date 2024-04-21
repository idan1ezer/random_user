import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/users/data/data_sources/remote/random_users_api_service.dart';
import 'features/users/data/data_sources/remote/users_api_service.dart';
import 'features/users/data/data_sources/remote/users_api_service_impl.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/users/domain/repositories/user_repository.dart';
import 'features/users/domain/usecases/get_users.dart';
import 'features/users/presentation/bloc/user/remote/remote_user_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
// Dio
  sl.registerSingleton<Dio>(Dio());

// Dependencies
  sl.registerSingleton<UsersRemoteDataSource>(UsersRemoteDataSource(sl()));
  sl.registerSingleton<UserRemoteDataSource>(UsersRemoteDataSourceImpl());


// Repositories
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl(),sl()));

// UseCases
  sl.registerSingleton<GetUsersUseCase>(GetUsersUseCase(sl()));

// Blocs
  sl.registerFactory<RemoteUserBloc>(() => RemoteUserBloc(sl()));
}