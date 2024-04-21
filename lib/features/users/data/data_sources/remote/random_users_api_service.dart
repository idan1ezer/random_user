
import 'package:action_item_project/features/users/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

part 'random_users_api_service.g.dart';

@RestApi(baseUrl: Urls.randomUserAPIBaseURL)
abstract class UsersRemoteDataSource {
  factory UsersRemoteDataSource(Dio dio) = _UsersRemoteDataSource;

  @GET('/?results={num}')
  Future<HttpResponse<List<UserModel>>> getTenUsers({
    @Path('num') int? num,
  });
}

// https://randomuser.me/api/?results=10