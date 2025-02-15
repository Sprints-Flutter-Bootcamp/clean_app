import 'package:clean_app/core/errors/failures.dart';
import 'package:clean_app/features/users/data/datasources/user_remote_data_src.dart';
import 'package:clean_app/features/users/data/models/user_model.dart';
import 'package:clean_app/features/users/domain/entities/user.dart';
import 'package:clean_app/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final users = await userRemoteDataSource.getUsers();
      return Right(users.map((user) => user.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

extension UserModelMapper on UserModel {
  User toEntity() {
    return User(
      id: 0,
      name: name,
      username: username,
      email: email,
      phone: phone,
      website: website,
    );
  }
}
