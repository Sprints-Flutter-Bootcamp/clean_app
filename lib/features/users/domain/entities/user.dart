// import 'package:equatable/equatable.dart';

// class Item extends Equatable {
//   final int id;
//   final String name;

//   const Item({required this.id, required this.name});

//   @override
//   List<Object?> get props => [id, name];
// }

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });
}
