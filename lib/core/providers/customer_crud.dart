import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/customer.dart';

class CustomerCRUDPage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCustomer({
    required String name,
    required String email,
    required String phone,
    required String company,
  }) async {
    try {
      await _firestore.collection('customers').add({
        'name': name,
        'email': email,
        'phone': phone,
        'company': company,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Müşteri eklenirken hata oluştu: $e');
    }
  }

  Future<void> addMultipleCustomers() async {
    List<Customer> customers = [
    ];

    for (Customer customer in customers) {
      await addCustomer(
        name: customer.name,
        email: customer.email,
        phone: customer.phone,
        company: customer.company,
      );
    }
  }
  Future<void> updateCustomer({
    required String docId,
    required String name,
    required String email,
    required String phone,
    required String company,
  }) async {
    try {
      await _firestore.collection('customers').doc(docId).update({
        'name': name,
        'email': email,
        'phone': phone,
        'company': company,
      });
    } catch (e) {
      print('Müşteri güncellenirken hata oluştu: $e');
    }
  }
  Future<void> deleteCustomer(String docId) async {
    try {
      await _firestore.collection('customers').doc(docId).delete();
    } catch (e) {
      print('Müşteri silinirken hata oluştu: $e');
    }
  }
  Stream<QuerySnapshot> getCustomers() {
    return _firestore.collection('customers').snapshots();
  }

  Stream<QuerySnapshot> getSortedCustomers() {
    return _firestore.collection('customers').orderBy('name').snapshots();
  }

  Stream<QuerySnapshot> searchCustomers(String searchQuery) {
    return _firestore
        .collection('customers')
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .snapshots();
  }

  Stream<QuerySnapshot> searchAndSortCustomers(String searchQuery, bool ascending) {
    Query query = _firestore.collection('customers')
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff');
    query = query.orderBy('name', descending: !ascending);
    return query.snapshots();
  }
}