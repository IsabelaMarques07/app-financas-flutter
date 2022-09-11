class Plano {
  int? id;
  String nome;
  double valorTotal;
  double valorAtual;
  DateTime dataInicial;
  DateTime dataFinal;

  Plano({
    this.id,
    required this.nome,
    required this.valorTotal,
    required this.valorAtual,
    required this.dataInicial,
    required this.dataFinal,
  });
}
