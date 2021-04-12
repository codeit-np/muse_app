import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';
import 'package:muse_app/component/inputText.dart';
import 'package:muse_app/const/const.dart';

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
        title: Text("Service Details"),
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
                                      link + snapshot.data['image']),
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
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (builder) {
                                          return AlertDialog(
                                            title: Text("Make an Appointment"),
                                            content: Container(
                                              height: 200,
                                              child: Column(
                                                children: [
                                                  inputText(
                                                      serviceName,
                                                      Icons
                                                          .miscellaneous_services_rounded,
                                                      'Service',
                                                      TextInputType.text,
                                                      false,
                                                      false)
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Calcel")),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Confirm"))
                                            ],
                                          );
                                        });
                                  },
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
