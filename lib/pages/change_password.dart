import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';
import 'package:muse_app/component/inputText.dart';
import 'package:muse_app/const/const.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future getData() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);
    email.text = data['email'];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              return Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      inputText(email, Icons.person, 'Email',
                          TextInputType.text, false, true),
                      inputText(password, Icons.lock, 'New Password',
                          TextInputType.text, true, true),
                      ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState.validate()) {
                              Map data = {"password": password.text};

                              var response =
                                  await Api().postData(data, 'changepassword');
                              var result = json.decode(response.body);
                              print(result);
                              if (result['message'] == 'success') {
                                showDialog(
                                    context: context,
                                    builder: (builder) {
                                      return AlertDialog(
                                        title: Text("Message"),
                                        content: Text("Password Changed"),
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
                          child: Text("Change Password"))
                    ],
                  ),
                ),
              );
          }
        },
      )),
    );
  }
}
