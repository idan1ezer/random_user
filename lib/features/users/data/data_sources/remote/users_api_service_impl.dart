import 'dart:convert';

import 'package:action_item_project/features/users/data/data_sources/remote/users_api_service.dart';
import 'package:http/http.dart' as http;

import '../../../domain/entities/user.dart';
import '../../models/user.dart';

class UsersRemoteDataSourceImpl implements UserRemoteDataSource {


  @override
  Future<List<UserEntity>> getTenUsers(int? num) async {
    final url = Uri.parse('https://randomuser.me/api/?results=$num');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final users = data['results'] as List<dynamic>;
      return users.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

}

