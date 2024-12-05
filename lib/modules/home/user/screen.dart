import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/colors.dart';
import '../../../core/providers/customer_crud.dart';
import '../../../core/providers/provider.dart';
import '../../../core/providers/user_data_provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _ascending = true;

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final customerCRUDPage = CustomerCRUDPage();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(
          'Anasayfa',
          style: TextStyle(color: Colors.white),
        ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Müşteri Ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(_ascending ? Icons.arrow_upward : Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    _ascending = !_ascending;
                  });
                },
              ),
              Text("Sıralama: ${_ascending ? 'A-Z' : 'Z-A'}")
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: customerCRUDPage.searchAndSortCustomers(_searchQuery, _ascending),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Henüz müşteri bulunmamaktadır.'));
                }
                final customers = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    final name = customer['name'];
                    final email = customer['email'];
                    final phone = customer['phone'];
                    final company = customer['company'];
                    return Card(
                      elevation: 5,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Icon(Icons.account_circle, size: 40, color: AppColors.secondary),
                        title: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text('Email: $email', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 4),
                            Text('Phone: $phone', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 4),
                            Text('Company: $company', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}