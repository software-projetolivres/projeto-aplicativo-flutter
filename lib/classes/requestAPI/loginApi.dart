import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class LoginAPI {
  static Future<Map> postLogin(email, senha) async {
    var url = "http://3.140.224.217:8080/api/login";

    var header = {"Content-Type": "application/json"};
    Map params = {"login": email, "senha": senha};

    var _body = json.encode(params);
    log(_body);
    var response = await http.post(Uri.parse(url), body: _body, headers: header);

    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      return mapResponse;
    } else {
      return null;
    }
  }
}
