import 'package:cloud_firestore/cloud_firestore.dart';

class Servico {
  int? id;
  int? idServico;
  String? descricao;
  String? preco;
  double? estrelas;
  int? avaliacoes;
  List<dynamic>? datasDisponiveis;
  String? imgNome;
  String? imgUrl;
  int indexDataSelecionada = 0;

  Servico({
    this.id,
    this.idServico,
    this.descricao,
    this.preco,
    this.estrelas,
    this.avaliacoes,
    this.datasDisponiveis,
    this.imgNome,
    this.imgUrl,
    this.indexDataSelecionada = 0,
  });

  factory Servico.fromJson(Map<String, dynamic> json) {
    return Servico(
      id: json["id"],
      idServico: json["idServico"],
      descricao: json["descricao"],
      preco: json["preco"],
      estrelas: json["estrelas"],
      avaliacoes: json["avaliacoes"],
      datasDisponiveis: (json["datasDisponiveis"]).map((date) => date.toDate()).toList(),
      imgNome: json["imgNome"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idServico": idServico,
      "descricao": descricao,
      "preco": preco,
      "estrelas": estrelas,
      "avaliacoes": avaliacoes,
      "datasDisponiveis": datasDisponiveis?.map((date) => date.toIso8601String()).toList(),
      "imgNome": imgNome,
    };
  }

  factory Servico.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Servico(
      id: data["id"],
      idServico: data["idServico"],
      descricao: data["descricao"],
      preco: data["preco"],
      estrelas: data["estrelas"] != null ? double.tryParse(data["estrelas"].toString()) : null,
      avaliacoes: data["avaliacoes"],
      datasDisponiveis: (data["datasDisponiveis"]).map((date) => date.toDate()).toList(),
      imgNome: data["imgNome"],
    );
  }
}
