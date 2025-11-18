import 'package:dashboard_tlpp/models/titulos.dart';
import 'package:dashboard_tlpp/screens/dashboard_screen/generated_screen/titulos_recentes_screen.dart';

List<TitulosRecentesScreen> generateTitulosRecentesScreen({
  required List<Titulos> listTitulos,
}) {
  List<TitulosRecentesScreen> list = [];
  int cont = 0;
  for(Titulos titulos in listTitulos) {
    if (cont < 3) {
      list.add(TitulosRecentesScreen(
        titulo: titulos,
      ));
    }
    cont++;
  }
  return list;
  }