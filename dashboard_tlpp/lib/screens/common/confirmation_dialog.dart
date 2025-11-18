import 'package:dashboard_tlpp/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<dynamic> showConfirmationDialog(BuildContext context,
    {String title = "Atenção!",
    String content = "Deseja realizar essa operação?",
    String affirmativeOption = "Confirmar"}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              "Cancelar",
              style: GoogleFonts.inter(
                color: AppColors.colorDeepBlue,
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              affirmativeOption.toUpperCase(),
              style: GoogleFonts.inter(
                color: AppColors.colorVeryDarkBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        ],
      );
    },
  );
}
