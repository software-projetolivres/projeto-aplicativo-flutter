import 'dart:convert';
import 'dart:developer';

import 'package:app_livres/classes/model/consumidor.dart';
import 'package:app_livres/classes/model/preComunidade.dart';
import 'package:http/http.dart' as http;

Future<List<PreComunidade>> precomunidades = PreComunidadeAPI.getPrecomunidades();

class PreComunidadeAPI {
  static Future<List<PreComunidade>> getPrecomunidades() async {
    final precomunidades = List<PreComunidade>();

    var url = "http://livresbs.herokuapp.com/api/precomunidade";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      List listResponse = responseJson;
      for (Map map in listResponse) {
        PreComunidade p = PreComunidade.fromJson(map);
        precomunidades.add(p);
      }
      return precomunidades;
    } else {
      return null;
    }
  }

  static Future<List<Consumidor>> getPrecomunidadeConsumidor(id) async {
    final consumidores = List<Consumidor>();
    var url = "http://livresbs.herokuapp.com/api/precomunidade/$id";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      List listResponse = responseJson["consumidores"];
      for (Map map in listResponse) {
        Consumidor c = Consumidor.fromJson(map);
        consumidores.add(c);
      }
      return consumidores;
    } else {
      return null;
    }
  }

  static Future<PreComunidade> postPrecomunidade(nome) async {
    var url = "http://livresbs.herokuapp.com/api/precomunidade";

    var header = {"Content-Type": "application/json"};
    Map params = {"nome": nome};

    var _body = json.encode(params);
    var response = await http.post(Uri.parse(url), body: _body, headers: header);
    var precomunidade;

    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      precomunidade = PreComunidade.fromJson(mapResponse);
    } else {
      precomunidade = null;
    }

    return precomunidade;
  }

  static Future<PreComunidade> editPrecomunidade(id, nome) async {
    var url = "http://livresbs.herokuapp.com/api/precomunidade";
    var header = {"Content-Type": "application/json"};
    Map params = {"nome": nome, "id": id, "consumidores": []};
    var _body = json.encode(params);
    var response = await http.put(Uri.parse(url), body: _body, headers: header);
    var precomunidade;

    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      precomunidade = PreComunidade.fromJson(mapResponse);
    } else {
      precomunidade = null;
    }

    return precomunidade;
  }

  static Future<bool> deletePrecomunidade(id) async {
    var url = "http://livresbs.herokuapp.com/api/precomunidade/$id";
    var header = {"Content-Type": "application/json"};
    var response = await http.delete(Uri.parse(url), headers: header);

    bool deletou;
    if (response.statusCode == 200) {
      deletou = true;
    } else {
      deletou = false;
    }

    return deletou;
  }
}
