import 'package:app_livres/classes/destination.dart';
import 'package:app_livres/screens/consumidores.dart';
import 'package:app_livres/screens/home.dart';
import 'package:app_livres/screens/pre_comunidade.dart';
import 'package:app_livres/screens/produtos.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  _HomeMenu createState() => _HomeMenu();
}

class _HomeMenu extends State<HomeMenu> {
  int _currentIndex = 0;

  final _homeMenuScreen = GlobalKey<NavigatorState>();
  final _precomunidadeScreen = GlobalKey<NavigatorState>();
  final _consumidorScreen = GlobalKey<NavigatorState>();
  final _produtoScreen = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Navigator(
            key: _homeMenuScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => HomeScreen(),
            ),
          ),
          Navigator(
            key: _precomunidadeScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => PreComunidadeScreen(),
            ),
          ),
          Navigator(
            key: _consumidorScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => ConsumidoresScreen(),
            ),
          ),
          Navigator(
            key: _produtoScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => ProdutoScreen(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (val) => _onTap(val, context),
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            backgroundColor: destination.color,
            label: destination.title,
          );
        }).toList(),
      ),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      switch (val) {
        case 0:
          _homeMenuScreen.currentState.popUntil((route) => route.isFirst);
          break;
        case 1:
          _precomunidadeScreen.currentState.popUntil((route) => route.isFirst);
          break;
        case 2:
          _consumidorScreen.currentState.popUntil((route) => route.isFirst);
          break;
        case 3:
          _produtoScreen.currentState.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
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
