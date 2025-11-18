import 'package:dashboard_tlpp/models/titulos.dart';
import 'package:dashboard_tlpp/screens/common/confirmation_dialog.dart';
import 'package:dashboard_tlpp/theme/app_colors.dart';
import 'package:dashboard_tlpp/utils/breakpoints.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TitulosRecentesScreen extends StatefulWidget{
  final Titulos titulo;
  TitulosRecentesScreen ({
    Key? key,
    required this.titulo}): super (key: key);

  @override
  State<StatefulWidget> createState() => _TitulosRecentesState();
}

class _TitulosRecentesState extends State<TitulosRecentesScreen> {
  NumberFormat numberFormatter = NumberFormat.decimalPatternDigits(
    locale: 'pt-br',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if(!isMobile(context)) {
      return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50), 
                offset: const Offset(2, 4), 
                blurRadius: 6, 
                spreadRadius: 2, 
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.titulo.nomcli.trim(),
                      style: GoogleFonts.inter(
                        color: AppColors.colorBlack,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 48.0),
                      child: (screenWidth > 908)
                      ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.colorBrightYellow.withAlpha(150),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 15, right: 15),
                          child: Text((widget.titulo.saldo > 0) ? 'Pendente' : "Pago", 
                            style: GoogleFonts.inter(
                              color: AppColors.colorBlack.withAlpha(120),
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                      : Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: (widget.titulo.saldo > 0) ? AppColors.colorBrightYellow.withAlpha(150) : AppColors.colorGreen.withAlpha(150),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                      )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 20),
                child: Text('R\$ ${numberFormatter.format(widget.titulo.valor)}',
                  style: GoogleFonts.inter(
                    color: AppColors.colorBlack,
                    fontSize: 23,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(widget.titulo.vencto,
                  style: GoogleFonts.inter(
                    color: AppColors.colorBlack.withAlpha(130),
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                    showConfirmationDialog(
                      context, 
                      title: "Detalhamento título", 
                      content: '${widget.titulo.nomcli.trim()}\n'
                               '${widget.titulo.vencto}\n'
                               'R\$ ${numberFormatter.format(widget.titulo.valor)}\n'
                               '${(widget.titulo.saldo > 0) ? 'Pendente' : "Pago"}', 
                      affirmativeOption: "Ok"
                    );
                  },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.colorBlack.withAlpha(30),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), 
                      bottomRight: Radius.circular(15))
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5, left: (screenWidth > 908) ? 100 : 60, right: (screenWidth > 908) ? 100 : 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Ver Título',
                            style: GoogleFonts.inter(
                              color: AppColors.colorBlack.withAlpha(80),
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(
                            Icons.chevron_right, size: 30, 
                            color: AppColors.colorBlack.withAlpha(80),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.02, right: screenWidth * 0.02, top:15),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50), 
                offset: const Offset(2, 4), 
                blurRadius: 6, 
                spreadRadius: 2, 
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 20),
                child: Row(
                  children: [
                    Text(widget.titulo.nomcli,
                      style: GoogleFonts.inter(
                        color: AppColors.colorBlack,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 68.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: (widget.titulo.saldo > 0) ? AppColors.colorBrightYellow.withAlpha(150) : AppColors.colorGreen.withAlpha(150),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 15, right: 15),
                          child: Text((widget.titulo.saldo > 0) ? 'Pendente' : "Pago",
                            style: GoogleFonts.inter(
                              color: AppColors.colorBlack.withAlpha(120),
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 20),
                child: Text('R\$ ${numberFormatter.format(widget.titulo.valor)}',
                  style: GoogleFonts.inter(
                    color: AppColors.colorBlack,
                    fontSize: 23,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(widget.titulo.vencto,
                  style: GoogleFonts.inter(
                    color: AppColors.colorBlack.withAlpha(130),
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showConfirmationDialog(
                    context, 
                    title: "Detalhamento título", 
                    content: '${widget.titulo.nomcli.trim()}\n${widget.titulo.vencto}\nR\$ ${numberFormatter.format(widget.titulo.valor)}\n${(widget.titulo.saldo > 0) ? 'Pendente' : "Pago"}', 
                    affirmativeOption: "Ok"
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.colorBlack.withAlpha(30),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), 
                      bottomRight: Radius.circular(15))
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5, left:100, right:100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Ver Título',
                            style: GoogleFonts.inter(
                              color: AppColors.colorBlack.withAlpha(80),
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(
                            Icons.chevron_right, size: 30, 
                            color: AppColors.colorBlack.withAlpha(80),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}