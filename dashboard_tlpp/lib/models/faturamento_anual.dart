class FaturamentoAnual {
  String mes;
  double honorarios;
  double saldo;
  double recebido;

  FaturamentoAnual({
    required this.mes,
    required this.honorarios,
    required this.saldo,
    required this.recebido,
});

  FaturamentoAnual.fromMap(Map<String, dynamic> map)
  : mes = map['mes'],
    honorarios = map['honorarios'],
    saldo = double.parse(map['saldo'].toString()),
    recebido = map['recebido'];
}