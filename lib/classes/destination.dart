import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

var colorFundo = Color.fromARGB(255, 75, 114, 223);
var colorFundo2 = Color.fromARGB(255, 34, 74, 190);

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, MaterialColor(0xFF29ABE2, colorAzul)),
  Destination('Pré Comunidade', Icons.group, MaterialColor(0xFF29ABE2, colorAzul)),
  Destination('Consumidor', Icons.person, MaterialColor(0xFF29ABE2, colorAzul)),
  Destination('Produtos', Icons.fastfood, MaterialColor(0xFF29ABE2, colorAzul)),
];

const Map<int, Color> colorAzul = {
  50: Color.fromARGB(255, 41, 171, 226),
  100: Color.fromARGB(255, 41, 171, 226),
  200: Color.fromARGB(255, 41, 171, 226),
  300: Color.fromARGB(255, 41, 171, 226),
  400: Color.fromARGB(255, 41, 171, 226),
  500: Color.fromARGB(255, 41, 171, 226),
  600: Color.fromARGB(255, 41, 171, 226),
  700: Color.fromARGB(255, 41, 171, 226),
  800: Color.fromARGB(255, 41, 171, 226),
  900: Color.fromARGB(255, 41, 171, 226),
};
