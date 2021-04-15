import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';
import 'package:muse_app/pages/product.dart';

import 'package:muse_app/const/const.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  Future getDetails(String endPoint) async {
    var response = await Api().getData(endPoint);
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service List"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: Text("Our Services"),
                subtitle: Text("Know more about our services"),
              ),
              FutureBuilder(
                future: getDetails('services'),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (contex, index) {
                          var mydata = snapshot.data[index];

                          return Card(
                            elevation: .2,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                              productID: mydata['id'],
                                            )));
                              },
                              leading: Container(
                                padding: EdgeInsets.all(10),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            link + mydata['image']),
                                        fit: BoxFit.cover)),
                              ),
                              title: Text(mydata['name'].toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rs." + mydata['price'].toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    mydata['description'].toString(),
                                    style: TextStyle(fontSize: 10),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
