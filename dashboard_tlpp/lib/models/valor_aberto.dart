class ValorAberto {
  double aberto;

  ValorAberto({
    required this.aberto,
});

  ValorAberto.fromMap(Map<String, dynamic> map)
  : aberto = map['aberto'];
}