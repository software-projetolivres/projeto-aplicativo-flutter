import 'dart:developer';

import 'package:app_livres/classes/model/preComunidade.dart';
import 'package:app_livres/classes/requestAPI/preComunidadeAPI.dart';
import 'package:app_livres/screens/precomunidade_consumidores.dart';
import 'package:flutter/material.dart';

class PreComunidadeScreen extends StatefulWidget {
  _PreComunidadeScreen createState() => _PreComunidadeScreen();
}

Future<List<PreComunidade>> precomunidadesAll;

final nomePreComunidade = TextEditingController();
final nomePreComunidadeEdit = TextEditingController();

class _PreComunidadeScreen extends State<PreComunidadeScreen> {
  @override
  void initState() {
    super.initState();
    precomunidadesAll = PreComunidadeAPI.getPrecomunidades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pré-Comunidade"),
        backgroundColor: Color.fromARGB(255, 41, 171, 226),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: precomunidadesAll,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Erro ao Acessar os Dados");
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<PreComunidade> precomunidades = snapshot.data;
          print(precomunidades[0].nome);
          return _conteudoBody(precomunidades);
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('floating'),
        onPressed: addPrecomunidade,
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 41, 171, 226),
      ),
    );
  }

  Widget _conteudoBody(precomunidades) {
    return precomunidades.length != 0
        ? RefreshIndicator(
            onRefresh: _getData,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: precomunidades.length,
              itemBuilder: (context, index) {
                if (precomunidades != null) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.group),
                      backgroundColor: Color.fromARGB(255, 41, 171, 226),
                      foregroundColor: Colors.white,
                    ),
                    title: Text(precomunidades[index].nome),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PreComunidadeViewConsumidores(
                                id: precomunidades[index].id,
                                nome: precomunidades[index].nome,
                              )));
                    },
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.orange,
                            onPressed: () {
                              editPreComunidade(precomunidades[index].id, precomunidades[index].nome);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () async {
                              bool fez = await PreComunidadeAPI.deletePrecomunidade(precomunidades[index].id);

                              if (fez) {
                                log("entrou no coiso");
                                final snack = SnackBar(content: Text("Pré-Comunidade ${precomunidades[index].nome} Excluída com Sucesso!"));

                                setState(() {
                                  precomunidades = PreComunidadeAPI.getPrecomunidades();
                                });

                                Scaffold.of(context).showSnackBar(snack);
                              } else {
                                setState(() {
                                  SnackBar(content: Text("Erro ao Excluir a Pré-Comunidade ${precomunidades[index].nome}"));
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Text("Não Há PreComunidades Cadastradas");
                }
              },
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  addPrecomunidade() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 50.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                  child: TextField(
                    key: Key('txt_add'),
                    decoration: InputDecoration(
                      hintText: "Nome da Pré-Comunidade",
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    controller: nomePreComunidade,
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 41, 171, 226),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32.0), bottomRight: Radius.circular(32.0)),
                    ),
                    child: FlatButton(
                      child: Text(
                        "Adicionar",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        log(nomePreComunidade.text);
                        Navigator.of(context).pop(true);
                        await PreComunidadeAPI.postPrecomunidade(nomePreComunidade.text);

                        setState(() {
                          precomunidadesAll = PreComunidadeAPI.getPrecomunidades();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  editPreComunidade(id, nome) {
    nomePreComunidadeEdit.text = nome;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 50.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                  child: TextField(
                    key: Key('txt_edit'),
                    decoration: InputDecoration(
                      hintText: "Nome da Pré-Comunidade",
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    controller: nomePreComunidadeEdit,
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 41, 171, 226),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32.0), bottomRight: Radius.circular(32.0)),
                    ),
                    child: FlatButton(
                      child: Text(
                        "Editar",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        log(nomePreComunidade.text);
                        Navigator.of(context).pop(true);
                        await PreComunidadeAPI.editPrecomunidade(id, nomePreComunidadeEdit.text);

                        setState(() {
                          precomunidadesAll = PreComunidadeAPI.getPrecomunidades();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getData() async {
    setState(() {
      precomunidadesAll = PreComunidadeAPI.getPrecomunidades();
    });
  }
}
