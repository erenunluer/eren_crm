import 'package:eren_crm/core/colors.dart';
import 'package:flutter/material.dart';
import '../../../core/providers/customer_crud.dart';

class CustomerAdd extends StatefulWidget {
  const CustomerAdd({super.key});

  @override
  _CustomerAddState createState() => _CustomerAddState();
}

class _CustomerAddState extends State<CustomerAdd> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, phone, company;
  final CustomerCRUDPage customerCRUDPage = CustomerCRUDPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Müşteri Ekle', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
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
                    await customerCRUDPage.addCustomer(
                      name: name,
                      email: email,
                      phone: phone,
                      company: company,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Müşteri eklendi')),
                    );
                  }
                },
                child: Text('Ekle', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // Buton rengi
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