// part of 'user_bloc.dart'; // didn't work i dont know why :(

import 'package:clean_app/features/users/data/models/user_model.dart';
import 'package:clean_app/features/users/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  List<Object> get props => [message];
}
