import 'package:dashboard_tlpp/screens/common/confirmation_dialog.dart';
import 'package:dashboard_tlpp/utils/breakpoints.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dashboard_tlpp/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceberRecebidosScreen extends StatefulWidget{
  double aberto;
  double receber;
  ReceberRecebidosScreen ({
    Key? key,
    required this.aberto,
    required this.receber,
  }): super (key: key);

  @override
  State<StatefulWidget> createState() => _ReceberRecebidosState();
}

class _ReceberRecebidosState extends State<ReceberRecebidosScreen> {
  NumberFormat numberFormatter = NumberFormat.decimalPatternDigits(
    locale: 'pt-br',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if(!isMobile(context)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('A Receber',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: AppColors.colorLightBlue,
                  fontSize: 16,
                ),
              ),
              Text('R\$ ${numberFormatter.format(widget.receber)}',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: AppColors.colorLightPurple,
                  fontSize: 27
                ),
              ),
              InkWell(
                onHover: (isHovering) {
                },
                onTap: () {
                  showConfirmationDialog(
                    context, 
                    title: "Detalhamento a receber", 
                    content: 'R\$ ${numberFormatter.format(widget.receber)}', 
                    affirmativeOption: "Ok"
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.colorDarkGrey.withAlpha(60),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0, right: 10),
                          child: Text('Ver tudo',
                            style: GoogleFonts.inter(
                              color: AppColors.colorWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3, right: 5),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: AppColors.colorBlack.withAlpha(80),
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Icon(
                              Icons.chevron_right, 
                              color: AppColors.colorWhite, 
                              size: 26,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recebido',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: AppColors.colorLightBlue,
                  fontSize: 16,
                ),
              ),
              Text('R\$ ${numberFormatter.format(widget.receber - widget.aberto)}',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: AppColors.colorLightPurple,
                  fontSize: 27
                ),
              ),
              InkWell(
                onHover: (isHovering) {
                },
                onTap: () {
                  showConfirmationDialog(
                    context, 
                    title: "Detalhamento recebido", 
                    content: 'R\$ ${numberFormatter.format(widget.receber - widget.aberto)}', 
                    affirmativeOption: "Ok"
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.colorDarkGrey.withAlpha(60),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0, right: 10),
                          child: Text('Ver tudo',
                            style: GoogleFonts.inter(
                              color: AppColors.colorWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3, right: 5),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: AppColors.colorBlack.withAlpha(80),
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Icon(
                              Icons.chevron_right, 
                              color: AppColors.colorWhite, 
                              size: 26,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Em Aberto',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: AppColors.colorLightBlue,
                  fontSize: 16,
                ),
              ),
              Text('R\$ ${numberFormatter.format(widget.aberto)}',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: AppColors.colorLightPurple,
                  fontSize: 27,
                ),
              ),
              InkWell(
                onHover: (isHovering) {
                },
                onTap: () {
                  showConfirmationDialog(
                    context, 
                    title: "Detalhamento em aberto", 
                    content: 'R\$ ${numberFormatter.format(widget.aberto)}', 
                    affirmativeOption: "Ok"
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.colorDarkGrey.withAlpha(60),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0, right: 10),
                          child: Text('Ver tudo',
                            style: GoogleFonts.inter(
                              color: AppColors.colorWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3, right: 5),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: AppColors.colorBlack.withAlpha(80),
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Icon(
                              Icons.chevron_right, 
                              color: AppColors.colorWhite, 
                              size: 26,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('A Receber',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      color: AppColors.colorLightBlue,
                      fontSize: 13,
                    ),
                  ),
                  Text('R\$ ${numberFormatter.format(widget.receber)}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      color: AppColors.colorLightPurple,
                      fontSize: 23
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.08),
                child: InkWell(
                  onHover: (isHovering) {
                  },
                  onTap: () {
                    showConfirmationDialog(
                      context, 
                      title: "Detalhamento a receber", 
                      content: 'R\$ ${numberFormatter.format(widget.receber)}', 
                      affirmativeOption: "Ok"
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorDarkGrey.withAlpha(60),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 10),
                            child: Text('Ver tudo',
                              style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0, bottom: 3, right: 5),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.colorBlack.withAlpha(80),
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Icon(
                                Icons.chevron_right, 
                                color: AppColors.colorWhite, 
                                size: 22,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.08, right: screenWidth * 0.08, top: 10),
            child: Divider(
              color: AppColors.colorLightBlue.withAlpha(80),
              thickness: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recebido',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      color: AppColors.colorLightBlue,
                      fontSize: 13,
                    ),
                  ),
                  Text('R\$ ${numberFormatter.format(widget.receber - widget.aberto)}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      color: AppColors.colorLightPurple,
                      fontSize: 23
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.08),
                child: InkWell(
                  onHover: (isHovering) {
                  },
                  onTap: () {
                    showConfirmationDialog(
                      context, 
                      title: "Detalhamento recebido", 
                      content: 'R\$ ${numberFormatter.format(widget.receber - widget.aberto)}', 
                      affirmativeOption: "Ok"
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorDarkGrey.withAlpha(60),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 10),
                            child: Text('Ver tudo',
                              style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0, bottom: 3, right: 5),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.colorBlack.withAlpha(80),
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Icon(
                                Icons.chevron_right, 
                                color: AppColors.colorWhite, 
                                size: 22,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.08, right: screenWidth * 0.08, top: 10),
            child: Divider(
              color: AppColors.colorLightBlue.withAlpha(80),
              thickness: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Em Aberto',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      color: AppColors.colorLightBlue,
                      fontSize: 13,
                    ),
                  ),
                  Text('R\$ ${numberFormatter.format(widget.aberto)}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      color: AppColors.colorLightPurple,
                      fontSize: 23
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.08),
                child: InkWell(
                  onHover: (isHovering) {
                  },
                  onTap: () {
                    showConfirmationDialog(
                      context, 
                      title: "Detalhamento em aberto", 
                      content: 'R\$ ${numberFormatter.format(widget.aberto)}', 
                      affirmativeOption: "Ok"
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorDarkGrey.withAlpha(60),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 10),
                            child: Text('Ver tudo',
                              style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0, bottom: 3, right: 5),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.colorBlack.withAlpha(80),
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Icon(
                                Icons.chevron_right, 
                                color: AppColors.colorWhite, 
                                size: 22,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    }
  }
}