import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:muse_app/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future getData(String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }

  Future postData(Map data, String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data));
    return response;
  }

  Future loginAndRegister(Map data, String endPoint) async {
    String url = baseUrl + endPoint;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(data));
    return response;
  }
}
