import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';
import 'package:muse_app/component/inputText.dart';
import 'package:muse_app/const/const.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

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
                    inputText(name, Icons.person_add, 'Full Name',
                        TextInputType.text, false, true),
                    //Email
                    inputText(email, Icons.email, 'Email',
                        TextInputType.emailAddress, false, true),

                    //Mobile
                    inputText(mobile, Icons.call, 'Mobile', TextInputType.phone,
                        false, true),

                    //Password
                    inputText(password, Icons.lock, 'Password',
                        TextInputType.text, true, true),

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
                                      "mobile": mobile.text,
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
