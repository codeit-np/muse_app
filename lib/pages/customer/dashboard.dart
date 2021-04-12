import 'package:flutter/material.dart';
import 'package:muse_app/component/drawer.dart';
import 'package:muse_app/component/home.dart';
import 'package:muse_app/component/map.dart';
import 'package:muse_app/component/profile.dart';
import 'package:muse_app/component/search.dart';

class CustomerDashboardScreen extends StatefulWidget {
  @override
  _CustomerDashboardScreenState createState() =>
      _CustomerDashboardScreenState();
}

class _CustomerDashboardScreenState extends State<CustomerDashboardScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: myDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          index = value;
          setState(() {});
        },
        currentIndex: index,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map_sharp), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      appBar: AppBar(
        title: Text("MUSE"),
      ),
      body: index == 0
          ? HomeComponent()
          : index == 1
              ? mapWidget()
              : index == 2
                  ? Search()
                  : ProfileComponent(),
    );
  }
}
