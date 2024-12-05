import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/utils/enums.dart';

class UserModel {
  final String email;
  final UserRole role;

  UserModel({required this.email, required this.role});

  // Firestore'dan gelen veriyi UserModel'e dönüştürme
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return UserModel(
      email: data['email'],
      role: UserRole.values.firstWhere((e) => e.toString() == 'UserRole.${data['role']}'),
    );
  }

  // Kullanıcıyı Firestore'a kaydetme
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role.toString().split('.').last,
    };
  }
}