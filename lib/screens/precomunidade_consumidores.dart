import 'dart:developer';

import 'package:app_livres/classes/model/consumidor.dart';
import 'package:app_livres/classes/requestAPI/preComunidadeAPI.dart';
import 'package:flutter/material.dart';

class PreComunidadeViewConsumidores extends StatefulWidget {
  final int id;
  final String nome;
  PreComunidadeViewConsumidores({Key key, this.id, this.nome}) : super(key: key);

  @override
  _PreComunidadeViewConsumidoresState createState() => _PreComunidadeViewConsumidoresState();
}

Future<List<Consumidor>> consumidoresAll;

class _PreComunidadeViewConsumidoresState extends State<PreComunidadeViewConsumidores> {
  @override
  void initState() {
    consumidoresAll = PreComunidadeAPI.getPrecomunidadeConsumidor(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 41, 171, 226),
      ),
      body: FutureBuilder(
        future: consumidoresAll,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return listBuilder(snapshot.data);
          }
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  listBuilder(consumidores) {
    if (consumidores.length == 0)
      return Center(child: Text("Não Há Consumidores Para Esta Pré-Comunidade"));
    else
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: consumidores.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 150,
            width: double.maxFinite,
            child: Card(
              elevation: 10,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 50,
                      ),
                      backgroundColor: Color.fromARGB(255, 41, 171, 226),
                      foregroundColor: Colors.white,
                      maxRadius: 35,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0, left: 30),
                        child: Text(
                          "${consumidores[index].nome} ${consumidores[index].sobrenome}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 30),
                        child: Text("CPF: ${formataCpf(consumidores[index].cpf)}"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
  }

  formataCpf(cpf) {
    String formata = cpf[0] + cpf[1] + cpf[2] + "." + cpf[3] + cpf[4] + cpf[5] + "." + cpf[6] + cpf[7] + cpf[8] + "-" + cpf[9] + cpf[10];
    return formata;
  }
}
