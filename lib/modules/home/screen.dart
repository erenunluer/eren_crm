import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/user_data_provider.dart';
import '../../core/utils/enums.dart';
import '../../core/providers/provider.dart';
import 'admin/admin.dart';
import 'user/screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);

    if (authProvider.user == null) {
      return Scaffold(
        body: Center(child: Text('Lütfen giriş yapın')),
      );
    }

    if (userDataProvider.userModel == null) {
      userDataProvider.fetchUserData(authProvider.user!.email!);

      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return userDataProvider.userModel!.role == UserRole.admin
        ? AdminScreen()
        : UserScreen();
  }
}