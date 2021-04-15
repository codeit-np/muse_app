import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';

class ProfileComponent extends StatefulWidget {
  @override
  _ProfileComponentState createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  String userId;

  Future getID() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);
    userId = data['id'].toString();
    setState(() {});
  }

  Future getData(Map input) async {
    var response = await Api().postData(input, 'tickets');
    var data = json.decode(response.body);
    return data;
  }

  @override
  void initState() {
    super.initState();
    getID();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            FutureBuilder(
              future: getData({"user_id": userId}),
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
                      itemBuilder: (context, index) {
                        var mydata = snapshot.data[index];

                        return Card(
                          elevation: .2,
                          child: ListTile(
                            title:
                                Text("Ticket No# " + mydata['id'].toString()),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                mydata['employee'] == null
                                    ? SizedBox()
                                    : Text(
                                        "Appoint with: " + mydata['employee'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                Text(
                                  "Service: " + mydata['service'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.event),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            mydata['date'],
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.lock_clock),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          mydata['time'] == null
                                              ? SizedBox()
                                              : Text(
                                                  mydata['time'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                mydata['approved'] == 0
                                    ? Text(
                                        "Not Approved",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      )
                                    : Text(
                                        "Approved",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.green),
                                      )
                              ],
                            ),
                          ),
                        );
                      },
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
