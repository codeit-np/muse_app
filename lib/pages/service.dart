import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';

class ServiceScreen extends StatefulWidget {
  final int serviceID;
  ServiceScreen({this.serviceID});

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  Future getData(String id) async {
    var response = await Api().getData('services/$id');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getData(widget.serviceID.toString()),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://192.168.1.100:8000/" +
                                          snapshot.data['image']),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text(snapshot.data['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price: " +
                                  snapshot.data['starting_price'].toString()),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Description",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              snapshot.data['description'] == null
                                  ? Text("Description not available")
                                  : Text(snapshot.data['description']),
                              Divider(),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Make an Appointment"))
                            ],
                          ),
                        )
                      ],
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
