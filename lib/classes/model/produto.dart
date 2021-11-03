class Produto {
  int cotacaoId;
  String nome;
  double preco;
  String categoria;
  String unidadeMedida;

  Produto({this.cotacaoId, this.nome, this.preco, this.categoria, this.unidadeMedida});

  Produto.fromJson(Map<String, dynamic> json) {
    cotacaoId = json['cotacaoId'];
    nome = json['nome'];
    preco = json['preco'];
    categoria = json['categoria'];
    unidadeMedida = json['unidadeMedida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cotacaoId'] = this.cotacaoId;
    data['nome'] = this.nome;
    data['preco'] = this.preco;
    data['categoria'] = this.categoria;
    data['unidadeMedida'] = this.unidadeMedida;
    return data;
  }
}
