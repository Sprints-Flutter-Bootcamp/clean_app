import 'package:clean_app/core/errors/failures.dart';
import 'package:clean_app/features/users/data/models/user_model.dart';
import 'package:clean_app/features/users/domain/entities/user.dart';
import 'package:clean_app/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, List<User>>> call() {
    return repository.getUsers();
  }
}
