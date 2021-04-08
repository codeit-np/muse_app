import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                              onPressed: () {}, child: Text("LOGIN")))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Are you new?',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: ' Register here',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
