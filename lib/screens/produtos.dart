import 'package:app_livres/classes/model/produto.dart';
import 'package:app_livres/classes/requestAPI/produtoAPI.dart';
import 'package:flutter/material.dart';

class ProdutoScreen extends StatefulWidget {
  ProdutoScreen({Key key}) : super(key: key);

  @override
  _ProdutoScreenState createState() => _ProdutoScreenState();
}

Future<List<Produto>> produtosall;

class _ProdutoScreenState extends State<ProdutoScreen> {
  @override
  void initState() {
    super.initState();
    produtosall = ProdutoAPI.getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 41, 171, 226),
      ),
      body: _body(),
    );
  }

  _body() {
    return FutureBuilder(
        future: produtosall,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao Carregar os Dados"),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Produto> p = snapshot.data;
          return _conteudoBody(p);
        });
  }

  _conteudoBody(produtos) {
    return RefreshIndicator(
        onRefresh: _getData,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemCount: produtos.length,
            itemBuilder: (context, index) => _produtoCard(produtos[index]),
          ),
        ));
  }

  _produtoCard(produto) {
    var nome = capitalize(produto.nome);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            //height: 180,
            //width: 160,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 41, 171, 226),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset("assets/img/logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              nome,
              style: TextStyle(
                color: Color(0xFFACACAC),
              ),
            ),
          ),
          Text(
            'RS ${produto.preco}0',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Future<void> _getData() async {
    setState(() {
      produtosall = ProdutoAPI.getProdutos();
    });
  }
}

String capitalize(String string) {
  if (string == null) {
    throw ArgumentError.notNull('string');
  }

  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}
