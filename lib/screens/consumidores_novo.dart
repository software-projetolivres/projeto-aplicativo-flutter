import 'dart:developer';

import 'package:app_livres/classes/model/consumidor.dart';
import 'package:app_livres/classes/model/preComunidade.dart';
import 'package:app_livres/classes/requestAPI/consumidorAPI.dart';
import 'package:app_livres/classes/requestAPI/preComunidadeAPI.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsumidoresScreenNE extends StatefulWidget {
  final String nomeE;
  final String sobrenomeE;
  final String cpfE;
  final int precomunidadeE;
  final bool edit;


  ConsumidoresScreenNE({Key key, this.edit, this.nomeE, this.sobrenomeE, this.cpfE, this.precomunidadeE}) : super(key: key);
  _ConsumidoresScreenNE createState() => _ConsumidoresScreenNE();
}

Future<List<Consumidor>> consumidoresAll;
List<PreComunidade> precomunidadeAll;

final nomePreComunidade = TextEditingController();

TextEditingController _controllerNome = new TextEditingController();
TextEditingController _controllerSobrenome = new TextEditingController();
TextEditingController _controllerCPF = new TextEditingController();
TextEditingController _controllerSenha = new TextEditingController();

class _ConsumidoresScreenNE extends State<ConsumidoresScreenNE> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _preComunidadeSelection;

  @override
  void initState() {
    if (widget.edit) {
      _controllerNome.text = widget.nomeE;
      _controllerSobrenome.text = widget.sobrenomeE;
      _controllerCPF.text = widget.cpfE;
      _preComunidadeSelection = widget.precomunidadeE.toString();
    } else {
      _controllerNome.text = "";
      _controllerSobrenome.text = "";
      _controllerCPF.text = "";
      _controllerSenha.text = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: widget.edit == true ? Text("Editar Consumidor") : Text("Novo Consumidor"),
        backgroundColor: Color.fromARGB(255, 41, 171, 226),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
                  child: textField(_controllerNome, "Nome", TextInputType.name, false),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
                  child: textField(_controllerSobrenome, "Sobrenome", TextInputType.name, false),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
                  child: textField(_controllerCPF, "CPF", TextInputType.number, false),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
                  child: textField(_controllerSenha, "Senha", TextInputType.text, true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, right: 25.0, left: 25.0),
                  child: Text(
                    "Pré-Comunidade",
                    style: TextStyle(color: Color.fromARGB(255, 41, 171, 226), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 25.0, left: 25.0),
                  child: dropdown(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 10),
                  child: FlatButton(
                    minWidth: 40,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () async {
                      if (widget.edit) {
                        log(_controllerNome.text);
                        log(_controllerSobrenome.text);
                        log(_controllerCPF.text);
                        log(_controllerSenha.text);
                        String cpf = _controllerCPF.text;
                        cpf = cpf.replaceAll('.', '');
                        cpf = cpf.replaceAll('-', '');
                        log("$cpf");
                        if (await ConsumidorAPI.putConsumidores(_controllerNome.text, _controllerSobrenome.text, cpf, _controllerSenha.text, int.parse(_preComunidadeSelection))) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Consumidor(a) ${_controllerNome.text} Adicionado(a) com Sucesso!")));

                          _controllerNome.clear();
                          _controllerSobrenome.clear();
                          _controllerCPF.clear();
                          _controllerSenha.clear();
                          Navigator.of(context).pop();
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Erro ao Adicionar o(a) Consumidor(a) ${_controllerNome.text}!")));
                        }
                        log("PreComunidade Escolhida $_preComunidadeSelection");
                      } else {
                        log(_controllerNome.text);
                        log(_controllerSobrenome.text);
                        log(_controllerCPF.text);
                        log(_controllerSenha.text);
                        String cpf = _controllerCPF.text;
                        cpf = cpf.replaceAll('.', '');
                        cpf = cpf.replaceAll('-', '');
                        log("$cpf");
                        if (await ConsumidorAPI.postConsumidores(_controllerNome.text, _controllerSobrenome.text, cpf, _controllerSenha.text, int.parse(_preComunidadeSelection))) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Consumidor(a) ${_controllerNome.text} Adicionado(a) com Sucesso!")));

                          _controllerNome.clear();
                          _controllerSobrenome.clear();
                          _controllerCPF.clear();
                          _controllerSenha.clear();
                          Navigator.of(context).pop();
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Erro ao Adicionar o(a) Consumidor(a) ${_controllerNome.text}!")));
                        }
                        log("PreComunidade Escolhida $_preComunidadeSelection");
                      }
                    },
                    color: Color.fromARGB(255, 41, 171, 226),
                    height: 45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textField(controller, nome, tipoTeclado, isPass) {
    return TextField(
      cursorColor: Color.fromARGB(255, 41, 171, 226),
      controller: controller,
      keyboardType: tipoTeclado,
      obscureText: isPass,
      style: TextStyle(color: Color.fromARGB(255, 41, 171, 226)),
      inputFormatters: nome == 'CPF'
          ? ([
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ])
          : ([]),
      readOnly: nome == 'CPF'
          ? widget.edit == true
              ? true
              : false
          : false,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 41, 171, 226))),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 41, 171, 226))),
          fillColor: Color.fromARGB(255, 41, 171, 226),
          focusColor: Color.fromARGB(255, 41, 171, 226),
          hoverColor: Color.fromARGB(255, 41, 171, 226),
          prefixIcon: null,
          labelText: nome,
          labelStyle: TextStyle(color: Color.fromARGB(255, 41, 171, 226), fontWeight: FontWeight.bold)),
    );
  }

  dropdown() {
    final Future<List<PreComunidade>> precomunidades = PreComunidadeAPI.getPrecomunidades();
    return FutureBuilder(
        future: precomunidades,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton(
              hint: Text(
                "Escolha uma Pré-Comunidade",
                style: TextStyle(color: Color.fromARGB(255, 41, 171, 226)),
              ),
              items: snapshot.data.map<DropdownMenuItem<String>>((precomunidade) {
                log("${precomunidade.id}");
                return DropdownMenuItem(
                  child: Text(
                    precomunidade.nome,
                    style: TextStyle(color: Color.fromARGB(255, 41, 171, 226)),
                  ),
                  value: precomunidade.id.toString(),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _preComunidadeSelection = newVal;
                });
              },
              value: _preComunidadeSelection,
            );
          } else {
            return Text('Carregando!');
          }
        });
  }
}
