import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';

import 'package:app_livres/classes/model/consumidor.dart';
import 'package:app_livres/classes/model/preComunidade.dart';
import 'package:http/http.dart' as http;

Future<List<Consumidor>> consumidores = ConsumidorAPI.getConsumidores();

class ConsumidorAPI {
  static Future<List<Consumidor>> getConsumidores() async {
    final consumidores = List<Consumidor>();
    var url = "http://3.140.224.217:8080/api/consumidor";
    var response = await http.get(Uri.parse(url));
    print(response.body);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      List listResponse = responseJson;

      for (Map map in listResponse) {
        Consumidor c = Consumidor.fromJson(map);
        consumidores.add(c);
      }
      return consumidores;
    } else {
      return null;
    }
  }

  static Future<bool> putConsumidores(nome, sobrenome, cpf, senha, precomunidade) async {
    var url = "http://3.140.224.217:8080/api/consumidor";

    var passBytes = utf8.encode(senha);
    var passEncode = sha256.convert(passBytes);

    var header = {"Content-Type": "application/json"};
    Map params = {"nome": nome, "sobrenome": sobrenome, "cpf": cpf, "senha": passEncode.toString(), "precomunidade": precomunidade};

    var _body = json.encode(params);
    log(_body);
    var response = await http.put(Uri.parse(url), body: _body, headers: header);

    print('Response Status Post: ${response.statusCode}');

    var fez;

    if (response.statusCode == 200) {
      log("FEZ O POST");
      fez = true;
    } else {
      fez = false;
    }

    return fez;
  }

  static Future<bool> postConsumidores(nome, sobrenome, cpf, senha, precomunidade) async {
    var url = "http://3.140.224.217:8080/api/consumidor";

    var passBytes = utf8.encode(senha);
    var passEncode = sha256.convert(passBytes);

    var header = {"Content-Type": "application/json"};
    Map params = {"nome": nome, "sobrenome": sobrenome, "cpf": cpf, "senha": passEncode.toString(), "precomunidade": precomunidade};

    var _body = json.encode(params);
    log(_body);
    var response = await http.post(Uri.parse(url), body: _body, headers: header);

    print('Response Status Post: ${response.statusCode}');

    var fez;

    if (response.statusCode == 200) {
      log("FEZ O POST");
      fez = true;
    } else {
      fez = false;
    }

    return fez;
  }

  static Future<bool> deleteConsumidor(cpf) async {
    var url = "http://3.140.224.217:8080/api/consumidor/$cpf";

    var header = {"Content-Type": "application/json"};

    log(url);
    var response = await http.delete(Uri.parse(url), headers: header);

    print('Response Status Post: ${response.statusCode}');

    bool deletou;
    if (response.statusCode == 200) {
      log("FEZ O DELETE");
      deletou = true;
    } else {
      deletou = false;
    }

    return deletou;
  }

  static Future<Consumidor> getConsumidor(String id, String token) async {
    final consumidores = List<Consumidor>();
    var url = "http://3.140.224.217:8080/api/consumidor/$id";
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}"
    };
    var response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      Map<String, dynamic> resp = responseJson;
      Consumidor c = Consumidor.fromJson(resp);
      return c;
    } else {
      return null;
    }
  }
}
