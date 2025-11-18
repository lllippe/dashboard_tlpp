import 'package:dashboard_tlpp/models/faturamento_anual.dart';
import 'package:dashboard_tlpp/models/faturamento_prefixo.dart';
import 'package:dashboard_tlpp/models/titulos.dart';
import 'package:dashboard_tlpp/models/valor_aberto.dart';
import 'package:dashboard_tlpp/models/valor_receber.dart';
import 'package:dashboard_tlpp/screens/dashboard_screen/generators/generate_receber_recebidos_screen.dart';
import 'package:dashboard_tlpp/screens/dashboard_screen/generators/generate_titulos_faturados_screen.dart';
import 'package:dashboard_tlpp/screens/dashboard_screen/generators/generate_titulos_recentes_screen.dart';
import 'package:dashboard_tlpp/services/faturamento_anual_service.dart';
import 'package:dashboard_tlpp/services/faturamento_prefixo_service.dart';
import 'package:dashboard_tlpp/services/titulos_service.dart';
import 'package:dashboard_tlpp/services/valor_aberto_service.dart';
import 'package:dashboard_tlpp/services/valor_receber_service.dart';
import 'package:dashboard_tlpp/theme/app_colors.dart';
import 'package:dashboard_tlpp/utils/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}): super (key: key);

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

enum SampleItem { itemOne, itemTwo, itemThree, itemFour, itemFive }

class _DashboardScreenState extends State<DashboardScreen> {
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserLogged();
    getFaturamentoAnual();
    getFaturamentoPrefixo();
    getTitulos();
    getValorReceber();
    getValorAberto();
  }

  bool _isHovering = true;
  bool isRequestReady = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usuarioController = TextEditingController();
  bool _passwordVsible = false;
  ScrollController _controller = ScrollController();
  SampleItem? selectedItem;
  List<FaturamentoAnual> listFaturamentoAnual = [];
  List<FaturamentoPrefixo> listFaturamentoPrefixo = [];
  List<Titulos> listTitulos = [];
  List<ValorReceber> listValorReceber = [];
  List<ValorAberto> listValorAberto = [];
  List<TableRow> listOfRows = [];
  List<TableRow> listOfRowsMobile = [];
  FaturamentoAnualService _faturamentoAnualService = FaturamentoAnualService();
  FaturamentoPrefixoService _faturamentoPrefixoService = FaturamentoPrefixoService();
  TitulosService _titulosService = TitulosService();
  ValorReceberService _valorReceberService = ValorReceberService();
  ValorAbertoService _valorAbertoService = ValorAbertoService();
  
  @override
  Widget build(BuildContext context) {
    if (isRequestReady) {
      if(!isMobile(context)) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          body: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gradientStartNearWhite,
                      AppColors.gradientEndCoolGray,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
              ),
              child: Scrollbar(
                controller: _controller,
                thumbVisibility: true,
                thickness: 7,
                radius: Radius.circular(30),
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 15),
                            child: Image.asset('assets/images/Logo_fr.png'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: (screenWidth > 908) ? screenWidth * 0.25 : screenWidth * 0.15, right: screenWidth * 0.04, top: screenHeight * 0.02),
                            child: InkWell(
                              onHover: (isHovering) {},
                              onTap: () {
                                print('Clique');
                              },
                              child: Text('Dashboard',
                                style: GoogleFonts.inter(
                                  color: AppColors.colorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.04, top: screenHeight * 0.02),
                            child: InkWell(
                              onHover: (isHovering) {},
                              onTap: () {
                                print('Clique');
                              },
                              child: Text('Títulos',
                                style: GoogleFonts.inter(
                                  color: AppColors.colorBlack.withAlpha(100),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.04, top: screenHeight * 0.02),
                            child: InkWell(
                              onHover: (isHovering) {},
                              onTap: () {
                                print('Clique');
                              },
                              child: Text('Pedidos',
                                style: GoogleFonts.inter(
                                  color: AppColors.colorBlack.withAlpha(100),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.02),
                            child: InkWell(
                              onHover: (isHovering) {},
                              onTap: () {
                                print('Clique');
                              },
                              child: Text('Account',
                                style: GoogleFonts.inter(
                                  color: AppColors.colorBlack.withAlpha(100),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.only(top: screenHeight * 0.02, left: (screenWidth > 1010) ? screenWidth * 0.2 : screenWidth * 0.06),
                            child: InkWell(
                              onTap: () {
                                logout();
                              },
                              child: Icon(
                                Icons.logout_rounded,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                      //Container Degrade Azul 
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          width: screenWidth,
                          height: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gradientStartDarkBlue,
                                AppColors.gradientEndDarkBlue,
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            )
                          ),
                          child: generateReceberRecebidosScreen(listValorAberto: listValorAberto, listValorReceber: listValorReceber)
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Cards
                          Row(
                            mainAxisAlignment: (screenWidth > 908) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 80, top: 30.0, bottom: 30),
                                child: Text('Títulos Recentes',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                  color: AppColors.colorBlack.withAlpha(130),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 200.0),
                                child: InkWell(
                                  onHover: (isHovering) {
                                  },
                                  onTap: () {
                                    print('Clique');
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.colorDeepBlue,
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 3.0, bottom: 3, left: 5),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: AppColors.colorBlack.withAlpha(100),
                                                borderRadius: BorderRadius.all(Radius.circular(30))
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: AppColors.colorWhite, 
                                                size: 26,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20, right: 15),
                                            child: Text('Incluir',
                                              style: GoogleFonts.inter(
                                                color: AppColors.colorWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: generateTitulosRecentesScreen(listTitulos: listTitulos)
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40.0, bottom: 20, left: screenWidth * 0.06, right: screenWidth * 0.06),
                            child: Divider(
                              color: AppColors.colorBlack.withAlpha(80),
                              thickness: 2,
                            ),
                          ),
                          //Gráficos
                          Padding(
                            padding: const EdgeInsets.only(left: 80, top: 10.0, bottom: 30),
                            child: Text('Resumo Faturamento Anual',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              color: AppColors.colorBlack.withAlpha(130),
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 15.0),
                                        child: Text('Faturamento mensal',
                                          style: GoogleFonts.inter(
                                            color: AppColors.colorBlack,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      SfCartesianChart(
                                          primaryXAxis: const CategoryAxis(),
                                          legend: const Legend(isVisible: true, position: LegendPosition.bottom),
                                          tooltipBehavior: TooltipBehavior(enable: true),
                                          series: <CartesianSeries>[
                                            SplineAreaSeries<FaturamentoAnual, String>(
                                              dataSource: listFaturamentoAnual,
                                              xValueMapper: (FaturamentoAnual data, _) => data.mes,
                                              yValueMapper: (FaturamentoAnual data, _) => data.honorarios,
                                              name: "Total Faturado",
                                              dataLabelSettings: const  DataLabelSettings(
                                                isVisible: true, angle: -60,
                                                labelIntersectAction: LabelIntersectAction.none,),
                                              gradient: LinearGradient(colors: [
                                                AppColors.gradientStartBrightPurple,
                                                AppColors.gradientEndLightPurple
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                          ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50, bottom: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 15.0),
                                          child: Text('Faturamento por prefixo',
                                          textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              color: AppColors.colorBlack,
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        SfCircularChart(
                                            legend: const Legend(isVisible: true, position: LegendPosition.bottom),
                                            tooltipBehavior: TooltipBehavior(enable: true),
                                            series: <CircularSeries>[
                                              DoughnutSeries<FaturamentoPrefixo, String>(
                                                dataSource: listFaturamentoPrefixo,
                                                xValueMapper: (FaturamentoPrefixo data, _) => data.prefixo,
                                                yValueMapper: (FaturamentoPrefixo data, _) => data.honorarios,
                                                name: "Total Faturado",
                                                dataLabelSettings: const  DataLabelSettings(
                                                  isVisible: true, angle: -60,
                                                  labelIntersectAction: LabelIntersectAction.none,),
                                              ),
                                            ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40.0, bottom: 20, left: screenWidth * 0.06, right: screenWidth * 0.06),
                            child: Divider(
                              color: AppColors.colorBlack.withAlpha(80),
                              thickness: 2,
                            ),
                          ),
                          //Tabela titulos
                          Padding(
                            padding: const EdgeInsets.only(left: 80, top: 10.0, bottom: 30),
                            child: Text('Títulos faturados',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.inter(
                                color: AppColors.colorBlack.withAlpha(130),
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: Center(
                              child: Container(
                                width: (screenWidth > 908) ? screenWidth * 0.8 : screenWidth * 0.95,
                                decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withAlpha(100),
                                      offset: const Offset(6, 6),
                                      blurRadius: 10,
                                      spreadRadius: 4,
                                    ),
                                  ], 
                                ),
                                child: Table(
                                  children: generateTitulosFaturadosScreen(listOfRows: listOfRows, listTitulos: listTitulos, context: context),
                                ),
                              ),
                            ),
                          ),
                          //Footer
                          Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                AppColors.gradientStartDarkBlue,
                                AppColors.gradientEndDarkBlue,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                              child: Text('Desenvolvido por FRPelissari',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.permanentMarker(
                                color: AppColors.colorWhite,
                                fontSize: 20
                              ),),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
        );
      } else {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          body: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gradientStartNearWhite,
                      AppColors.gradientEndCoolGray,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 20),
                          child: Image.asset('assets/images/Logo_fr.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0, top: 10),
                            child: PopupMenuButton<SampleItem>(
                            initialValue: selectedItem,
                            onSelected: (SampleItem item) {
                              setState(() {
                                selectedItem = item;
                              });
                            },
                            icon: Icon(
                              Icons.menu_rounded,
                              size: 40,
                            ),
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemOne, 
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.dashboard_customize,
                                      color: AppColors.colorBlack.withAlpha(70),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text('Dashboard'),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemTwo, 
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.table_chart,
                                      color: AppColors.colorBlack.withAlpha(70),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text('Títulos'),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemThree, 
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.task_outlined,
                                      color: AppColors.colorBlack.withAlpha(70),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text('Pedidos'),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemFour, 
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.manage_accounts_outlined,
                                      color: AppColors.colorBlack.withAlpha(70),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text('Account'),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<SampleItem>(
                                onTap: () {
                                  logout();
                                },
                                value: SampleItem.itemFive, 
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout_rounded,
                                      color: AppColors.colorBlack.withAlpha(70),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text('Sair'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    //Resumo financeiro
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        width: screenWidth,
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.gradientStartDarkBlue,
                              AppColors.gradientEndDarkBlue,
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: generateReceberRecebidosScreen(listValorAberto: listValorAberto, listValorReceber: listValorReceber)
                        ),
                      ),
                    ),
                    //Ultimos títulos incluidos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 30.0, bottom: 30),
                          child: Text('Títulos Recentes',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            color: AppColors.colorBlack.withAlpha(130),
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: InkWell(
                            onHover: (isHovering) {
                            },
                            onTap: () {
                              print('Clique');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.colorDeepBlue,
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0, bottom: 3, left: 5),
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: AppColors.colorBlack.withAlpha(100),
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.colorWhite, 
                                          size: 23,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12, right: 15),
                                      child: Text('Incluir',
                                        style: GoogleFonts.inter(
                                          color: AppColors.colorWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: generateTitulosRecentesScreen(listTitulos: listTitulos)
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0, bottom: 20, left: screenWidth * 0.06, right: screenWidth * 0.06),
                      child: Divider(
                        color: AppColors.colorBlack.withAlpha(80),
                        thickness: 2,
                      ),
                    ),
                    //Gráficos
                    Padding(
                      padding: const EdgeInsets.only(left: 35, top: 10.0, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Resumo Faturamento Anual',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              color: AppColors.colorBlack.withAlpha(130),
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.95,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Text('Faturamento mensal',
                                    style: GoogleFonts.inter(
                                      color: AppColors.colorBlack,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SfCartesianChart(
                                    primaryXAxis: const CategoryAxis(),
                                    legend: const Legend(isVisible: true, position: LegendPosition.bottom),
                                    tooltipBehavior: TooltipBehavior(enable: true),
                                    series: <CartesianSeries>[
                                      SplineAreaSeries<FaturamentoAnual, String>(
                                        dataSource: listFaturamentoAnual,
                                        xValueMapper: (FaturamentoAnual data, _) => data.mes,
                                        yValueMapper: (FaturamentoAnual data, _) => data.honorarios,
                                        name: "Total Faturado",
                                        dataLabelSettings: const  DataLabelSettings(
                                          isVisible: true, angle: -60,
                                          labelIntersectAction: LabelIntersectAction.none,),
                                        gradient: LinearGradient(colors: [
                                          AppColors.gradientStartBrightPurple,
                                          AppColors.gradientEndLightPurple
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Text('Faturamento por prefixo',
                                    style: GoogleFonts.inter(
                                      color: AppColors.colorBlack,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SfCircularChart(
                                    legend: const Legend(isVisible: true, position: LegendPosition.bottom),
                                    tooltipBehavior: TooltipBehavior(enable: true),
                                    series: <CircularSeries>[
                                      DoughnutSeries<FaturamentoPrefixo, String>(
                                        dataSource: listFaturamentoPrefixo,
                                        xValueMapper: (FaturamentoPrefixo data, _) => data.prefixo,
                                        yValueMapper: (FaturamentoPrefixo data, _) => data.honorarios,
                                        name: "Total Faturado",
                                        dataLabelSettings: const  DataLabelSettings(
                                          isVisible: true, angle: -60,
                                          labelIntersectAction: LabelIntersectAction.none,),
                                      ),
                                    ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20, left: screenWidth * 0.06, right: screenWidth * 0.06),
                      child: Divider(
                        color: AppColors.colorBlack.withAlpha(80),
                        thickness: 2,
                      ),
                    ),
                    //Tabela
                    Padding(
                      padding: const EdgeInsets.only(left: 35, top: 10.0, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Títulos faturados',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              color: AppColors.colorBlack.withAlpha(130),
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Center(
                        child: Container(
                          width: (screenWidth > 908) ? screenWidth * 0.8 : screenWidth * 0.95,
                          decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(100),
                                offset: const Offset(6, 6),
                                blurRadius: 10,
                                spreadRadius: 4,
                              ),
                            ], 
                          ),
                          child: Table(
                            children: generateTitulosFaturadosScreen(listOfRows: listOfRowsMobile, listTitulos: listTitulos, context: context),
                          ),
                        ),
                      ),
                    ),
                    //Footer
                    Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          AppColors.gradientStartDarkBlue,
                          AppColors.gradientEndDarkBlue,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Text('Desenvolvido por FRPelissari',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.permanentMarker(
                          color: AppColors.colorWhite,
                          fontSize: 16
                        ),),
                      ),
                    )
                  ],
                ),
              ),
            ),
        );
      }
    } else {
      return Flexible(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.colorDeepBlue
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text('Aguarde carregar as informações.',
                style: GoogleFonts.inter(
                  color: AppColors.colorVeryDarkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ],
          ),
        ),
      );
    }
  }
  
  void getUserLogged() {
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString('token');
      if (token == null) {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }

  void logout() {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.remove('token');
      Navigator.pushReplacementNamed(context, 'login');
    });
  }
  
  void getFaturamentoAnual() async {
    SharedPreferences.getInstance().then((prefs) {
      listFaturamentoAnual = [];
      String? token = prefs.getString('token');
      if (token != null) {
        _faturamentoAnualService.getAll().then((List<FaturamentoAnual> listFAnual) {
          for(FaturamentoAnual fanual in listFAnual) {
            setState(() {
              listFaturamentoAnual.add(
                FaturamentoAnual(
                  mes: "${fanual.mes}/2025", 
                  honorarios: fanual.honorarios, 
                  saldo: fanual.saldo, 
                  recebido: fanual.recebido
                ),
              );
            });
          }
        });
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }
  
  void getFaturamentoPrefixo() async {
    SharedPreferences.getInstance().then((prefs) {
      listFaturamentoPrefixo = [];
      String? token = prefs.getString('token');
      if (token != null) {
        _faturamentoPrefixoService.getAll().then((List<FaturamentoPrefixo> listFPrefixo) {
          for(FaturamentoPrefixo fprefixo in listFPrefixo) {
            setState(() {
              listFaturamentoPrefixo.add(
                FaturamentoPrefixo(
                  prefixo: fprefixo.prefixo, 
                  honorarios: fprefixo.honorarios, 
                  saldo: fprefixo.saldo, 
                  recebido: fprefixo.recebido
                ),
              );
            });
          }
        });
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }
  
  void getTitulos() {
    SharedPreferences.getInstance().then((prefs) {
      listTitulos = [];
      listOfRows = [];
      listOfRowsMobile = [];
      String? token = prefs.getString('token');
      if (token != null) {
        _titulosService.getAll().then((List<Titulos> listTit) {
          for(Titulos titulos in listTit) {
            setState(() {
              listTitulos.add(
                Titulos(
                  nomcli: titulos.nomcli, 
                  vencto: titulos.vencto, 
                  valor: titulos.valor, 
                  saldo: titulos.saldo, 
                  titulo: titulos.titulo,
                )
              );
            });
          }
        });
        if (!isMobile(context)) {
          listOfRows.add(           
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Text('Cliente',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                        color: AppColors.colorBlack.withAlpha(130),
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: 
                      Text('Vencimento',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                          color: AppColors.colorBlack.withAlpha(130),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 80),
                    child: Text(
                        'Valor',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                        color: AppColors.colorBlack.withAlpha(130),
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Center(
                      child: Text(
                        'Status',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                          color: AppColors.colorBlack.withAlpha(130),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(),
                ),
              ]
            ),
          );
        } else {
          listOfRowsMobile.add(
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Text('Cliente',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                        color: AppColors.colorBlack.withAlpha(130),
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Text(
                        'Valor',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                        color: AppColors.colorBlack.withAlpha(130),
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ]
            ),
          );
        }
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }
  
  void getValorAberto() {
    SharedPreferences.getInstance().then((prefs) {
      listValorAberto = [];
      String? token = prefs.getString('token');
      if (token != null) {
        _valorAbertoService.getAll().then((List<ValorAberto> listVAberto) {
          for(ValorAberto vaberto in listVAberto) {
            setState(() {
              listValorAberto.add(
                ValorAberto(
                  aberto: vaberto.aberto,
                )
              );
            });
          }
        });
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }
  
  void getValorReceber() {
    SharedPreferences.getInstance().then((prefs) {
      listValorReceber = [];
      String? token = prefs.getString('token');
      if (token != null) {
        _valorReceberService.getAll().then((List<ValorReceber> listVReceber) {
          for(ValorReceber vreceber in listVReceber) {
            setState(() {
              listValorReceber.add(
                ValorReceber(
                  receber: vreceber.receber,
                )
              );
            });
          }
          setState(() {
            isRequestReady = true;
          });
        });
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }
}