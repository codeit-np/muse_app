import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';
import 'package:muse_app/const/const.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  final int productID;
  ProductScreen({this.productID});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future getData(String id) async {
    var response = await Api().getData('products/$id');
    var data = json.decode(response.body);
    return data;
  }

  void _launchURL(String number) async {
    await canLaunch(number)
        ? await launch(number)
        : throw 'Could not launch $number';
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
              future: getData(widget.productID.toString()),
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
                                  snapshot.data['price'].toString()),
                              Text("Company: " +
                                  snapshot.data['company'].toString()),
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
                              ElevatedButton.icon(
                                  onPressed: () {
                                    _launchURL("tel:9804066012");
                                  },
                                  icon: Icon(Icons.call),
                                  label: Text("Make a call"))
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
