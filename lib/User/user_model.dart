import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['Name'] ?? '',
        email: data['Email'] ?? '',
        phone: data['Phone'] ?? '',
        password: data['Password'] ?? '',
      );
    } else {
      return emptyUser();
    }
  }

  static emptyUser() {
    return {
      "Name": 'empty',
      "Email": 'empty',
      "Phone": 'empty',
      "Password": 'empty',
    };
  }

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      "Name": user.name,
      "Email": user.email,
      "Phone": user.phone,
      "Password": user.password,
    };
  }
}