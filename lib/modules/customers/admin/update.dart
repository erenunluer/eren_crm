import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eren_crm/core/colors.dart';
import 'package:flutter/material.dart';
import '../../../core/providers/customer_crud.dart';

class CustomerUpdate extends StatefulWidget {
  const CustomerUpdate({super.key});

  @override
  _CustomerUpdateState createState() => _CustomerUpdateState();
}

class _CustomerUpdateState extends State<CustomerUpdate> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _ascending = true;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customerCRUDPage = CustomerCRUDPage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Müşteri Güncelle', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
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
                    final docId = customer.id;
                    final name = customer['name'];
                    final email = customer['email'];
                    final phone = customer['phone'];
                    final company = customer['company'];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Icon(Icons.account_circle, size: 40, color: AppColors.secondary),
                        title: Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
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
                        trailing: IconButton(
                          icon: Icon(Icons.edit, color: AppColors.secondary),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateCustomerForm(
                                  docId: docId,
                                  name: name,
                                  email: email,
                                  phone: phone,
                                  company: company,
                                  customerCRUDPage: customerCRUDPage,
                                ),
                              ),
                            );
                          },
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

class UpdateCustomerForm extends StatefulWidget {
  final String docId;
  final String name;
  final String email;
  final String phone;
  final String company;
  final CustomerCRUDPage customerCRUDPage;

  const UpdateCustomerForm({
    required this.docId,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.customerCRUDPage,
    super.key,
  });

  @override
  _UpdateCustomerFormState createState() => _UpdateCustomerFormState();
}

class _UpdateCustomerFormState extends State<UpdateCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, phone, company;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    email = widget.email;
    phone = widget.phone;
    company = widget.company;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Müşteri Bilgilerini Güncelle', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.secondary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Adı',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ad boş bırakılamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-posta boş bırakılamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: phone,
                decoration: InputDecoration(
                  labelText: 'Telefon',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => phone = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telefon boş bırakılamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: company,
                decoration: InputDecoration(
                  labelText: 'Şirket',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => company = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şirket adı boş bırakılamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await widget.customerCRUDPage.updateCustomer(
                      docId: widget.docId,
                      name: name,
                      email: email,
                      phone: phone,
                      company: company,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Müşteri güncellendi')),
                    );
                  }
                },
                child: Text('Güncelle', style: TextStyle(fontSize: 16, color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}