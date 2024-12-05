import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String name;
  String email;
  String phone;
  String company;

  Customer({
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
  });

  // Firestore için veri hazırlama
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}