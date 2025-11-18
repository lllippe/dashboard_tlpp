class Titulos {
  String nomcli;
  String vencto;
  double valor;
  double saldo;
  String titulo;

  Titulos({
    required this.nomcli,
    required this.vencto,
    required this.valor,
    required this.saldo,
    required this.titulo,
});

  Titulos.fromMap(Map<String, dynamic> map)
  : nomcli = map['nomcli'],
    vencto = map['vencto'],
    valor = double.parse(map['valor'].toString()),
    saldo = map['saldo'],
    titulo = map['titulo'];
}