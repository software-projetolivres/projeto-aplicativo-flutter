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
    print("RESPONSE STATUS PROJETOS ${response.statusCode}");
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      log("RESPONSE PRECOMUNIDADE ==> ${response.body}");

      List listResponse = responseJson;
      print("LISTA ==> $listResponse");
      for (Map map in listResponse) {
        print("MAP ==> $map");
        PreComunidade p = PreComunidade.fromJson(map);
        print("P ==> ${p.nome}");
        precomunidades.add(p);
      }
      print(precomunidades[0].nome);
      return precomunidades;
    } else {
      print("RESPONSE STATUS PROJETOS ${response.statusCode}");
      return null;
    }
  }

  static Future<List<Consumidor>> getPrecomunidadeConsumidor(id) async {
    final consumidores = List<Consumidor>();
    log("Precomunidade ID $id");
    var url = "http://livresbs.herokuapp.com/api/precomunidade/$id";
    log("$url");
    var response = await http.get(Uri.parse(url));
    print("RESPONSE STATUS PROJETOS ${response.statusCode}");
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      log("RESPONSE PRECOMUNIDADE ==> ${response.body}");

      List listResponse = responseJson["consumidores"];
      print("LISTA ==> $listResponse");
      for (Map map in listResponse) {
        Consumidor c = Consumidor.fromJson(map);
        consumidores.add(c);
      }
      return consumidores;
    } else {
      print("RESPONSE STATUS PROJETOS ${response.statusCode}");
      return null;
    }
  }

  static Future<PreComunidade> postPrecomunidade(nome) async {
    var url = "http://livresbs.herokuapp.com/api/precomunidade";

    var header = {"Content-Type": "application/json"};
    Map params = {"nome": nome};

    var _body = json.encode(params);
    log(_body);
    var response = await http.post(Uri.parse(url), body: _body, headers: header);

    print('Response Status Post: ${response.statusCode}');

    var precomunidade;

    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      precomunidade = PreComunidade.fromJson(mapResponse);
      log("FEZ O POST");
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
    log(_body);
    var response = await http.put(Uri.parse(url), body: _body, headers: header);

    print('Response Status Post: ${response.statusCode}');

    var precomunidade;

    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      precomunidade = PreComunidade.fromJson(mapResponse);
      log("FEZ O POST");
    } else {
      precomunidade = null;
    }

    return precomunidade;
  }

  static Future<bool> deletePrecomunidade(id) async {
    var url = "http://livresbs.herokuapp.com/api/precomunidade/$id";

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
}
