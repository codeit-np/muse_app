import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget myDrawer(context) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            child: Text("S"),
          ),
          accountName: Text("Samyak Shakya"),
          accountEmail: Text("samyak@gmail.com"),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.dashboard),
          title: Text("Dashboard"),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, 'productlist');
          },
          leading: Icon(Icons.food_bank),
          title: Text("Products"),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, 'servicelist');
          },
          leading: Icon(Icons.supervised_user_circle),
          title: Text("Services"),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, 'changepassword');
          },
          leading: Icon(Icons.lock_clock),
          title: Text("Change Password"),
        ),
        ListTile(
          onTap: () async {
            Map data = {};
            var response = await Api().postData(data, 'logout');
            var result = json.decode(response.body);
            print(result);
            if (result['message'] == 'success') {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.remove('token');
              Navigator.popAndPushNamed(context, 'login');
            }
          },
          leading: Icon(Icons.logout),
          title: Text("Logout"),
        ),
      ],
    ),
  );
}
