import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  String _errorMessage = '';

  User? get user => _user;
  String get errorMessage => _errorMessage;

  Future<void> signIn(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _user = _auth.currentUser;

      _errorMessage = '';
      notifyListeners();

      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _errorMessage = 'Bu e-posta adresi ile kayıtlı bir kullanıcı bulunamadı.';
      } else if (e.code == 'wrong-password') {
        _errorMessage = 'Şifreniz yanlış, lütfen tekrar deneyin.';
      } else if (e.code == 'invalid-email') {
        _errorMessage = 'Geçersiz e-posta adresi.';
      } else if (e.code == 'network-request-failed') {
        _errorMessage = 'Ağ bağlantınızda bir sorun oluştu. Lütfen internet bağlantınızı kontrol edin.';
      } else if (e.code == 'too-many-requests') {
        _errorMessage = 'Çok fazla başarısız giriş denemesi yapıldı. Lütfen birkaç dakika bekleyin ve tekrar deneyin.';
      } else {
        _errorMessage = 'Giriş yaparken bir hata oluştu. Lütfen tekrar deneyin.';
      }
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    _errorMessage = '';
    notifyListeners();
  }
}