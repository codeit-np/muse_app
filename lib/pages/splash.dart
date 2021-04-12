import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    if (token != null) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.popAndPushNamed(context, 'dashboard');
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.popAndPushNamed(context, 'login');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Your Logo Goes Here"),
        ),
      ),
    );
  }
}
