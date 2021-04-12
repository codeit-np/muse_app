import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muse_app/api/api.dart';
import 'package:muse_app/const/const.dart';
import 'package:muse_app/pages/product.dart';
import 'package:muse_app/pages/service.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String word;

  Future getData(Map data, String param) async {
    var response = await Api().postData(data, 'search');
    var result = json.decode(response.body)[param];
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              word = value;
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent)),
              hintText: 'Search eg, hair, face etc',
            ),
          ),
          SizedBox(),
          FutureBuilder(
            future: getData({"name": word}, 'data'),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  // return Text(snapshot.data[0]['products'][0]['name']);
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data[0]['products'].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductScreen(
                                                productID: snapshot.data[0]
                                                    ['products'][index]['id'],
                                              )));
                                },
                                child: Card(
                                  elevation: .2,
                                  child: ListTile(
                                    leading: Container(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(link +
                                          snapshot.data[0]['products'][index]
                                              ['image']),
                                    ),
                                    title: Text(snapshot.data[0]['products']
                                        [index]['name']),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "NRs." +
                                              snapshot.data[0]['products']
                                                      [index]['price']
                                                  .toString(),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          snapshot.data[0]['products'][index]
                                                  ['description']
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                          maxLines: 3,
                                        ),
                                        Divider(),
                                        Text(
                                          "Product | Company: " +
                                              snapshot.data[0]['products']
                                                      [index]['company']
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),

                      // Service
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data[0]['services'].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ServiceScreen(
                                                serviceID: snapshot.data[0]
                                                    ['services'][index]['id'],
                                              )));
                                },
                                child: Card(
                                  elevation: .2,
                                  child: ListTile(
                                    leading: Container(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(link +
                                          snapshot.data[0]['services'][index]
                                              ['image']),
                                    ),
                                    title: Text(snapshot.data[0]['services']
                                        [index]['name']),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Starting Price NRs." +
                                              snapshot.data[0]['services']
                                                      [index]['starting_price']
                                                  .toString(),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Divider(),
                                        Text(
                                          snapshot.data[0]['services'][index]
                                                  ['description']
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                          maxLines: 3,
                                        ),
                                        Divider(),
                                        Text(
                                          "Service",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      )
                    ],
                  );
              }
            },
          )
        ],
      ),
    ));
  }
}
