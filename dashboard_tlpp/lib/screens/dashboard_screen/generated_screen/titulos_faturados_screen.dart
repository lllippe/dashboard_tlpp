import 'package:dashboard_tlpp/models/titulos.dart';
import 'package:dashboard_tlpp/screens/common/confirmation_dialog.dart';
import 'package:dashboard_tlpp/utils/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_tlpp/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

TableRow buildTableRow(Titulos titulo, BuildContext context, bool isLineGrey, bool isEof){
  NumberFormat numberFormatter = NumberFormat.decimalPatternDigits(
    locale: 'pt-br',
    decimalDigits: 2,
  );
  double screenWidth = MediaQuery.of(context).size.width;
  if(!isMobile(context)) {
    return TableRow(
      decoration: BoxDecoration(
        color: isLineGrey? AppColors.colorCoolGray.withAlpha(100) : AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          bottomLeft: isEof ? Radius.circular(15) : Radius.circular(0),
          bottomRight: isEof ? Radius.circular(15) : Radius.circular(0),
        )
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: (screenWidth > 908) ? 20.0: 5),
                    child: (screenWidth > 908)
                    ? Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.colorRed.withAlpha(100),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                    )
                    :Container()
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titulo.nomcli.trim(),
                        style: GoogleFonts.inter(
                          color: AppColors.colorBlack.withAlpha(130),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(titulo.titulo,
                        style: GoogleFonts.inter(
                          color: AppColors.colorBlack.withAlpha(130),
                          fontSize: 14,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,                                      
          child: Center(
            child: Text(titulo.vencto,
              style: GoogleFonts.inter(
                color: AppColors.colorBlack.withAlpha(130),
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,                                      
          child: Text('R\$ ${numberFormatter.format(titulo.valor)}',
          textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: AppColors.colorBlack.withAlpha(130),
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,                                      
          child: Center(
            child: (screenWidth > 908)
            ? Container(
                decoration: BoxDecoration(
                  color: (titulo.saldo > 0) ? AppColors.colorRed.withAlpha(65) : AppColors.colorGreen.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text((titulo.saldo > 0) ? 'Em aberto' : "Pago",
                    style: GoogleFonts.inter(
                      color: AppColors.colorBlack.withAlpha(120),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            : Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: (titulo.saldo > 0) ? AppColors.colorRed.withAlpha(65) : AppColors.colorGreen.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 20),
                  child: Text((titulo.saldo > 0) ? 'A' : 'P',
                    style: GoogleFonts.inter(
                      color: AppColors.colorBlack.withAlpha(120),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: InkWell(
            onTap: () {
              showConfirmationDialog(
                context,
                title: 'Detalhamento título',
                content: '${titulo.nomcli}\n${titulo.titulo}\n${titulo.valor}\n${titulo.vencto}',
                affirmativeOption: 'Ok',
              );
            },
            child: Text('Detalhes',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColors.colorRoyalBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
          ),
        ),
      ],
    );
  } else {
    return TableRow(
      decoration: BoxDecoration(
        color: isLineGrey? AppColors.colorCoolGray.withAlpha(100) : AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          bottomLeft: isEof ? Radius.circular(15) : Radius.circular(0),
          bottomRight: isEof ? Radius.circular(15) : Radius.circular(0),
        )
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titulo.nomcli.trim(),
                        style: GoogleFonts.inter(
                          color: AppColors.colorBlack.withAlpha(130),
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(titulo.vencto,
                        style: GoogleFonts.inter(
                          color: AppColors.colorBlack.withAlpha(130),
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(titulo.titulo,
                        style: GoogleFonts.inter(
                          color: AppColors.colorBlack.withAlpha(130),
                          fontSize: 13,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,                                      
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: (titulo.saldo > 0) ? AppColors.colorRed.withAlpha(65) : AppColors.colorGreen.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
              ),
              Text('R\$ ${numberFormatter.format(titulo.valor)}',
              textAlign: TextAlign.right,
                style: GoogleFonts.inter(
                  color: AppColors.colorBlack.withAlpha(130),
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
              InkWell(
                onTap: () {
                  showConfirmationDialog(
                    context,
                    title: 'Detalhamento título',
                    content: '${titulo.nomcli}\n${titulo.titulo}\n${titulo.valor}\n${titulo.vencto}',
                    affirmativeOption: 'Ok',
                  );
                },
                child: Icon(
                  Icons.chevron_right_outlined,
                  color: AppColors.colorRoyalBlue,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}