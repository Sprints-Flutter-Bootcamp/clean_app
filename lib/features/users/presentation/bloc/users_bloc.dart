import 'package:bloc/bloc.dart';
import 'package:clean_app/features/users/domain/usecases/get_users.dart';
import 'package:clean_app/features/users/presentation/bloc/users_event.dart';
import 'package:clean_app/features/users/presentation/bloc/users_state.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;

  UserBloc({required this.getUsers}) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      final result = await getUsers();

      result.fold(
        (failure) => emit(UserError(message: "Failed to load users")),
        (users) => emit(UserLoaded(users: users)),
      );
    });
  }
}
