import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgms/screens/add_appoinment.dart';
import 'package:sgms/screens/admin.dart';
import 'package:sgms/screens/adminlogin.dart';
import 'package:sgms/screens/dashboard.dart';
import 'package:sgms/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SGMS',
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const HomeScreen(),
        "/dashboard": (context) => const Dashboard(),
        "/dashboard/add": (context) => const AddAppoinment(),
        "/admin": (context) => const AdminLogin(),
        "/admin/dashboard": (context) => const Admin(),
      },
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
