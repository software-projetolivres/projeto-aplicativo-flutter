class Consumidor {
  String nome;
  String sobrenome;
  String cpf;
  String senha;
  int precomunidade;

  Consumidor({this.nome, this.sobrenome, this.cpf, this.senha, this.precomunidade});

  Consumidor.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    cpf = json['cpf'];
    senha = json['senha'];
    precomunidade = json['precomunidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['sobrenome'] = this.sobrenome;
    data['cpf'] = this.cpf;
    data['senha'] = this.senha;
    data['precomunidade'] = this.precomunidade;
    return data;
  }
}
