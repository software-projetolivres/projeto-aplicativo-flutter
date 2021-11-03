class PreComunidade {
  int id;
  List<Consumidores> consumidores;
  String nome;

  PreComunidade({this.id, this.consumidores, this.nome});

  PreComunidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['consumidores'] != null) {
      consumidores = new List<Consumidores>();
      json['consumidores'].forEach((v) {
        consumidores.add(new Consumidores.fromJson(v));
      });
    }
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.consumidores != null) {
      data['consumidores'] = this.consumidores.map((v) => v.toJson()).toList();
    }
    data['nome'] = this.nome;
    return data;
  }
}

class Consumidores {
  String cpf;
  String nome;
  String sobrenome;
  List<Null> enderecos;

  Consumidores({this.cpf, this.nome, this.sobrenome, this.enderecos});

  Consumidores.fromJson(Map<String, dynamic> json) {
    cpf = json['cpf'];
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    if (json['enderecos'] != null) {
      enderecos = new List<Null>();
      json['enderecos'].forEach((v) {});
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['nome'] = this.nome;
    data['sobrenome'] = this.sobrenome;
    return data;
  }
}
