import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    //logo
                    FlutterLogo(
                      size: 50,
                    ),
                    //Email
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    //Password
                    TextFormField(
                      controller: password,
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
                                onPressed: () async {
                                  if (_key.currentState.validate()) {
                                    Map data = {
                                      "email": email.text,
                                      "password": password.text
                                    };

                                    var response = await Api()
                                        .loginAndRegister(data, 'login');
                                    var result = json.decode(response.body);
                                    print(result);
                                    if (result['message'] ==
                                        "Unauthorized user") {
                                      showDialog(
                                          context: context,
                                          builder: (builder) {
                                            return AlertDialog(
                                              title: Text("Message"),
                                              content:
                                                  Text("Unauthorized user"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("OK"))
                                              ],
                                            );
                                          });
                                    }

                                    if (result['user']['is_admin'] == 0) {
                                      Navigator.popAndPushNamed(
                                          context, 'dashboard');
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (builder) {
                                            return AlertDialog(
                                              title: Text("Message"),
                                              content: Text(
                                                  "Welcome to Employee Dashboard"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("OK"))
                                              ],
                                            );
                                          });
                                    }
                                  }
                                },
                                child: Text("LOGIN")))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: RichText(
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
