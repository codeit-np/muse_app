import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:muse_app/const/const.dart';

class Api {
  Future getData(String endPoint) async {
    String url = baseUrl + endPoint;
    var response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    return response;
  }

  Future postData(Map data, String endPoint) async {
    String url = baseUrl + endPoint;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
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
