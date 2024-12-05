import 'package:flutter/material.dart';
import 'package:eren_crm/modules/auth/auth.dart';
import 'package:eren_crm/modules/home/admin/admin.dart';
import 'package:eren_crm/modules/home/user/screen.dart';
import '../modules/home/screen.dart';

class AppRoutes {
  static const String auth = '/auth';
  static const String home = '/home';
  static const String admin = '/admin';
  static const String user = '/user';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (_) => AuthScreen(),);
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case admin:
        return MaterialPageRoute(builder: (_) => AdminScreen(),);
      case user:
        return MaterialPageRoute(builder: (_) => UserScreen(),);
      default:
        return MaterialPageRoute(builder: (_) => Container(child: Text("Page Not Found")));
    }
  }
}