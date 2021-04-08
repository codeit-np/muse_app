import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  String baseURL = "http://192.168.0.101:8000/api/";

  Future getData(String endPoint) async {
    String url = baseURL + endPoint;
    var response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    return response;
  }

  Future postData(Map data, String endPoint) async {
    String url = baseURL + endPoint;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(data));
    return response;
  }

  Future loginAndRegister(Map data, String endPoint) async {
    String url = baseURL + endPoint;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(data));
    return response;
  }
}
