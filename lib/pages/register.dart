import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
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
                    // Name
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Full Name',
                      ),
                      validator: (value) => value.isEmpty ? 'required' : null,
                    ),
                    //Email
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value.isEmpty ? 'required' : null,
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
                      validator: (value) => value.isEmpty ? 'required' : null,
                    ),
                    //Login Button
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_key.currentState.validate()) {
                                    Map data = {
                                      "name": name.text,
                                      "email": email.text,
                                      "password": password.text,
                                      "is_admin": 0
                                    };

                                    var response = await Api()
                                        .loginAndRegister(data, 'register');
                                    var result = json.decode(response.body);
                                    print(result);
                                    if (result['message'] == 'success') {
                                      showDialog(
                                          context: context,
                                          builder: (builder) {
                                            return AlertDialog(
                                              title: Text("Message"),
                                              content: Text(
                                                  "Registration successful"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context, 'login');
                                                    },
                                                    child: Text("OK"))
                                              ],
                                            );
                                          });
                                    }
                                  }
                                },
                                child: Text("REGISTER")))
                      ],
                    ),
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
