import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBHH2TJbOB2_VjpuFm8vQtSErQ9XRtVyAY',
        appId: '1:956186226796:android:3052f42178e601c3142849',
        messagingSenderId: '956186226796',
        projectId: 'eren-crm',
      ),
    );
  }
}