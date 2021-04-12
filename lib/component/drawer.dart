import 'package:flutter/material.dart';

Widget myDrawer() {
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
          onTap: () {},
          leading: Icon(Icons.dashboard),
          title: Text("Dashboard"),
        )
      ],
    ),
  );
}
