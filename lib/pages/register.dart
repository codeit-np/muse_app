import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  //logo
                  FlutterLogo(
                    size: 50,
                  ),
                  // Name
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Full Name',
                    ),
                  ),
                  //Email
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  //Password
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Your secret password',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.visibility), onPressed: () {})),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                  ),
                  //Login Button
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("REGISTER")))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
