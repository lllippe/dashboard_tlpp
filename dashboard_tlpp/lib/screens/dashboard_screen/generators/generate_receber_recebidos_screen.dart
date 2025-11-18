import 'package:dashboard_tlpp/models/titulos.dart';
import 'package:dashboard_tlpp/models/valor_aberto.dart';
import 'package:dashboard_tlpp/models/valor_receber.dart';
import 'package:dashboard_tlpp/screens/dashboard_screen/generated_screen/receber_recebidos_screen.dart';
import 'package:dashboard_tlpp/screens/dashboard_screen/generated_screen/titulos_recentes_screen.dart';
import 'package:flutter/widgets.dart';

Widget generateReceberRecebidosScreen({
  required List<ValorAberto> listValorAberto,
  required List<ValorReceber> listValorReceber,
}) {
  //Widget list = <Widget>;
  double vReceber = 0;
  double vAberto = 0;
  for(ValorAberto aberto in listValorAberto) {
    vAberto = aberto.aberto;
  }
  for(ValorReceber receber in listValorReceber) {
    vReceber = receber.receber;
  }
  //list.add(ReceberRecebidosScreen(aberto: vAberto, receber: vReceber));
  return ReceberRecebidosScreen(aberto: vAberto, receber: vReceber);
  }