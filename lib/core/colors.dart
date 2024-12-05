import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff3A668A); // Ana tema rengi
  static const Color secondary = Color(0xff99BAD5); // Vurgulu ikinci tema rengi
  static const Color background = Color(0xffEDF3F8); // Arka plan rengi
  static const Color textPrimary = Color(0xff655F5F); // Ana metin rengi
  static const Color textSecondary = Color(0xFF607D8B); // Yardımcı metin rengi


  static const LinearGradient darkGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient profileGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color success = Color(0xff4CAF50); // Başarılı durumlar için
  static const Color error = Color(0xffF44336); // Hata durumları için
  static const Color warning = Color(0xffFF9800); // Uyarılar için
}