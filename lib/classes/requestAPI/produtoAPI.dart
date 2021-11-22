import 'dart:convert';
import 'dart:developer';

import 'package:app_livres/classes/model/produto.dart';
import 'package:http/http.dart' as http;

class ProdutoAPI {
  static Future<List<Produto>> getProdutos() async {
    var produtosAll = List<Produto>();

    var url = "http://3.140.224.217:8080/api/loja/produtos";

    var header = {
      "Content-Type": "application/json",
      "cpf": "123",
      };

    var response = await http.get(Uri.parse(url), headers: header);

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      List<dynamic> listjson = body["produtos"];

      log(listjson.toString());

      for (Map map in listjson) {
        Produto p = Produto.fromJson(map);

        produtosAll.add(p);
      }

      return produtosAll;
    } else
      return null;
  }
}
