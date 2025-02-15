import 'package:clean_app/features/users/data/datasources/user_remote_data_src.dart';
import 'package:clean_app/features/users/data/repositories/user_repository_impl.dart';
import 'package:clean_app/features/users/domain/repositories/user_repository.dart';
import 'package:clean_app/features/users/domain/usecases/get_users.dart';
import 'package:clean_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // External
  sl.registerLazySingleton(() => Dio());

  // Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: sl()),
  );

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Bloc
  sl.registerFactory(() => UserBloc(getUsers: sl()));
}
