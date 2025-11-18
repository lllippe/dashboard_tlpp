class ValorReceber {
  double receber;

  ValorReceber({
    required this.receber,
});

  ValorReceber.fromMap(Map<String, dynamic> map)
  : receber = map['receber'];
  
}