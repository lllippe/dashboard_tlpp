import 'package:dashboard_tlpp/models/titulos.dart';
import 'package:dashboard_tlpp/screens/dashboard_screen/generated_screen/titulos_faturados_screen.dart';
import 'package:flutter/material.dart';

List<TableRow> generateTitulosFaturadosScreen({
  required List<TableRow> listOfRows,
  required List<Titulos> listTitulos,
  required BuildContext context,
}) {
  int lenListTitulos = listTitulos.length;
  int lineCount = 0;
  bool isLineGrey = false;
  bool isEof = false;

  for(Titulos titulos in listTitulos) {
    (lineCount % 2 == 0) ? isLineGrey = true : isLineGrey = false;
    (lineCount == (lenListTitulos - 1)) ? isEof = true : isEof = false;
    listOfRows.add(buildTableRow(titulos, context, isLineGrey, isEof));
    lineCount++;
  }
  return listOfRows;
  }