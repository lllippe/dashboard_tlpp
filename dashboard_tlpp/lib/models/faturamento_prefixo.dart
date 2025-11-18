class FaturamentoPrefixo {
  String prefixo;
  double honorarios;
  double saldo;
  double recebido;

  FaturamentoPrefixo({
    required this.prefixo,
    required this.honorarios,
    required this.saldo,
    required this.recebido,
});

  FaturamentoPrefixo.fromMap(Map<String, dynamic> map)
  : prefixo = map['prefixo'],
    honorarios = double.parse(map['honorarios'].toString()),
    saldo = double.parse(map['saldo'].toString()),
    recebido = double.parse(map['recebido'].toString());
}