import 'dart:developer';

import 'package:app_livres/classes/model/consumidor.dart';

import 'package:app_livres/classes/requestAPI/consumidorAPI.dart';
import 'package:app_livres/classes/requestAPI/preComunidadeAPI.dart';
import 'package:app_livres/screens/consumidores_novo.dart';
import 'package:flutter/material.dart';

class ConsumidoresScreen extends StatefulWidget {
  _ConsumidoresScreen createState() => _ConsumidoresScreen();
}

Future<List<Consumidor>> consumidoresAll;

final nomePreComunidade = TextEditingController();

class _ConsumidoresScreen extends State<ConsumidoresScreen> {
  @override
  void initState() {
    super.initState();
    consumidoresAll = ConsumidorAPI.getConsumidores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumidor"),
        backgroundColor: Color.fromARGB(255, 41, 171, 226),
        centerTitle: true,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        heroTag: "btncons",
        key: Key('floating'),
        onPressed: () async {
          await Navigator.of(context).push(_createRoute(ConsumidoresScreenNE(
            edit: false,
          )));
          setState(() {
            consumidoresAll = ConsumidorAPI.getConsumidores();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 41, 171, 226),
      ),
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: consumidoresAll,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Erro ao Acessar os Dados");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Consumidor> consumidores = snapshot.data;
        print(consumidores[0].nome);
        return _conteudoBody(consumidores);
      },
    );
  }

  Widget _conteudoBody(consumidores) {
    return consumidores.length != 0
        ? RefreshIndicator(
            onRefresh: _getData,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: consumidores.length,
              itemBuilder: (context, index) {
                if (consumidores != null) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                      backgroundColor: Color.fromARGB(255, 41, 171, 226),
                      foregroundColor: Colors.white,
                    ),
                    title: Text("${consumidores[index].nome} ${consumidores[index].sobrenome}"),
                    subtitle: Text("CPF: ${formataCpf(consumidores[index].cpf)}"),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.orange,
                            onPressed: () async {
                              await Navigator.of(context).push(_createRoute(ConsumidoresScreenNE(
                                edit: true,
                                nomeE: consumidores[index].nome,
                                sobrenomeE: consumidores[index].sobrenome,
                                cpfE: consumidores[index].cpf,
                                precomunidadeE: consumidores[index].precomunidade,
                              )));
                              setState(() {
                                consumidoresAll = ConsumidorAPI.getConsumidores();
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () async {
                              bool fez = await ConsumidorAPI.deleteConsumidor(consumidores[index].cpf);

                              if (fez) {
                                log("entrou no coiso");
                                final snack = SnackBar(content: Text("Consumidor(a) ${consumidores[index].nome} Excluído(a) com Sucesso!"));

                                setState(() {
                                  consumidoresAll = ConsumidorAPI.getConsumidores();
                                });

                                Scaffold.of(context).showSnackBar(snack);
                              } else {
                                setState(() {
                                  SnackBar(content: Text("Erro ao Excluir o(a) Consumidor(a) ${consumidores[index].nome}"));
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  );
                } else {
                  return Text("Não Há Consumidores Cadastrados");
                }
              },
            ))
        : Center(child: CircularProgressIndicator());
  }

  Future<void> _getData() async {
    setState(() {
      consumidoresAll = ConsumidorAPI.getConsumidores();
    });
  }

  String _valueDrop = "1";

  formataCpf(cpf) {
    String formata = cpf != null && cpf.length >= 10 ? cpf[0] + cpf[1] + cpf[2] + "." + cpf[3] + cpf[4] + cpf[5] + "." + cpf[6] + cpf[7] + cpf[8] + "-" + cpf[9] + cpf[10] : "";
    return formata;
  }
}

Route _createRoute(page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
