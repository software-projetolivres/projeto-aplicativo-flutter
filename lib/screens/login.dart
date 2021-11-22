import 'dart:convert';

import 'package:app_livres/classes/requestAPI/loginApi.dart';
import 'package:app_livres/classes/requestAPI/consumidorAPI.dart';
import 'package:app_livres/screens/consumidores_novo.dart';
import 'package:app_livres/screens/home_menu.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 171, 226),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SizedBox(
              width: 200,
              child: Image.asset("assets/img/logo.png"),
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              height: 450,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Bem-Vindo ao Livres",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
                    child: TextField(
                      controller: emailController,
                      key: Key('email'),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   CpfInputFormatter(),
                      // ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        labelText: 'E-mail',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 25.0, left: 25.0),
                    child: TextField(
                      controller: passwordController,
                      key: Key('senha'),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        labelText: 'Senha',
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 25.0, left: 25.0),
                      child: Container(
                        child: FlatButton(
                          child: Text(
                            "Acessar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            var loggedIn = await LoginAPI.postLogin(emailController.text, passwordController.text);
                            if (loggedIn != null) {
                              Map<String, dynamic> decoded = JwtDecoder.decode(loggedIn["token"]);
                              var userData = await ConsumidorAPI.getConsumidor(decoded["user-id"], loggedIn["token"]);
                              print(userData.cpf);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMenu()));
                            } else {
                               showDialog(  
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Erro"),
                                    content: Text("Email ou senha inválido(s)."),
                                    actions: [
                                      FlatButton(
                                        child: Text("Fechar"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ]
                                  );
                                });
                            }
                          },
                          color: Color.fromARGB(255, 41, 171, 226),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        height: 50,
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 40.0, right: 25.0, left: 25.0),
                      child: Container(
                        child: FlatButton(
                          child: Text(
                            "Criar conta",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            ///TODO Check Login
                            ///TODO If login admin
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumidoresScreenNE(edit: false)));

                            ///TODO If Login user
                            ///TODO Create Route to User Screen
                          },
                          color: Color.fromARGB(255, 41, 171, 226),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        height: 50,
                      )
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

// Future navigateToSubPage(context) async {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMenu()));
// }

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomeMenu(),
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
