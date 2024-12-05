import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';

class UserDataProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  Future<void> fetchUserData(String email) async {
    try {
      QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userDoc = userSnapshot.docs.first;
        _userModel = UserModel.fromFirestore(userDoc);
        notifyListeners();
      } else {
        _userModel = null;
        notifyListeners();
      }
    } catch (e) {
      print('Kullanıcı verisi çekilemedi: $e');
      _userModel = null;
      notifyListeners();
    }
  }

  void resetUserRoleLocally() {
    if (_userModel != null) {
      _userModel = null;
      notifyListeners();
    }
  }
}