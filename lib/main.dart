import 'package:flutter/material.dart';
import 'package:muse_app/pages/customer/dashboard.dart';
import 'package:muse_app/pages/login.dart';
import 'package:muse_app/pages/register.dart';
import 'package:muse_app/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muse',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      routes: {
        '/': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => RegisterScreen(),
        'dashboard': (context) => CustomerDashboardScreen()
      },
    );
  }
}
