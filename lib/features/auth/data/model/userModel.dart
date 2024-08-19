import 'package:clean/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: name ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
