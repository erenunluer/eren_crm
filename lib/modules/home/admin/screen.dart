import 'package:eren_crm/core/colors.dart';
import 'package:eren_crm/modules/customers/admin/add.dart';
import 'package:eren_crm/modules/customers/admin/admin.dart';
import 'package:eren_crm/modules/customers/admin/remove.dart';
import 'package:eren_crm/modules/customers/admin/update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/provider.dart';
import '../../../core/providers/user_data_provider.dart';

class AdminScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Anasayfa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              userDataProvider.resetUserRoleLocally();
              Provider.of<AuthProvider>(context, listen: false).signOut().then((_) {
                Navigator.pushReplacementNamed(context, '/auth');
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildActionButton(
                    icon: Icons.list,
                    label: 'Müşterileri Listele',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerScreen()),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.remove_circle_outline,
                    label: 'Müşteri Kaldır',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerRemove()),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.edit,
                    label: 'Müşteri Güncelle',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerUpdate()),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.add,
                    label: 'Müşteri Ekle',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerAdd()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}