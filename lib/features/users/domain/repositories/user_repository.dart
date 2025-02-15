import 'package:clean_app/core/errors/failures.dart';
import 'package:clean_app/features/users/data/models/user_model.dart';
import 'package:clean_app/features/users/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
}
