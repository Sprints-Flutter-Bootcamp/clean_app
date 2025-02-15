// part of 'user_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {}
