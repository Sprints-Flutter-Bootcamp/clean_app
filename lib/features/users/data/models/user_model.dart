// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

// List<UserModel> userModelFromJson(String str) =>
//     List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

List<UserModel> userModelFromJson(String str) {
  final List<dynamic> jsonData =
      json.decode(str) as List<dynamic>; // Explicit cast
  return jsonData
      .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
      .toList();
}

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int ?? 0,
        name: json['name']?.toString() ?? '',
        username: json['username']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        address: json['address'] is Map<String, dynamic>
            ? Address.fromJson(json['address'] as Map<String, dynamic>)
            : Address(
                street: '',
                suite: '',
                city: '',
                zipcode: '',
                geo: Geo(lat: '', lng: '')),
        phone: json['phone']?.toString() ?? '',
        website: json['website']?.toString() ?? '',
        company: json['company'] is Map<String, dynamic>
            ? Company.fromJson(json['company'] as Map<String, dynamic>)
            : Company(name: '', catchPhrase: '', bs: ''),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address.toJson(),
        'phone': phone,
        'website': website,
        'company': company.toJson(),
      };
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street']?.toString() ?? '',
        suite: json['suite']?.toString() ?? '',
        city: json['city']?.toString() ?? '',
        zipcode: json['zipcode']?.toString() ?? '',
        geo: json['geo'] is Map<String, dynamic>
            ? Geo.fromJson(json['geo'] as Map<String, dynamic>)
            : Geo(lat: '', lng: ''),
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': geo.toJson(),
      };
}

class Geo {
  String lat;
  String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json['lat']?.toString() ?? '',
        lng: json['lng']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json['name']?.toString() ?? '',
        catchPhrase: json['catchPhrase']?.toString() ?? '',
        bs: json['bs']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'catchPhrase': catchPhrase,
        'bs': bs,
      };
}
