import 'package:clean_app/features/users/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});
  String endpoint = 'https://jsonplaceholder.typicode.com/users';

  @override
  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    try {
      print('Calling API');
      var response = await Dio().get(endpoint);
      var data = response.data;
      // data.forEach((user) => users.add(UserModel.fromJson(user)));
      if (data is List) {
        for (var user in data) {
          if (user is Map<String, dynamic>) {
            users.add(UserModel.fromJson(user));
          }
        }
      }
    } catch (e) {
      print('Catching error!');
      print(e.toString());
    }
    print('Returning users');
    return users;
  }
}
