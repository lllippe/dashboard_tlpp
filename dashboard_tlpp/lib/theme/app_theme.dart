// app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

// Definindo as famílias de fonte como constantes
class AppFonts {
  static const String text = 'Inter';
  static const String developer = 'Permanent Marker';
}

final ThemeData appTheme = ThemeData(
  // 1. Define a fonte principal para o app (simula :root --font-text)
  fontFamily: AppFonts.text, 
  
  // 2. Define o esquema de cores
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.colorWhite,
    secondary: AppColors.colorBrightYellow,
    background: AppColors.colorLightOrange,
    // Você pode mapear mais cores do AppColors aqui
  ),

  // 3. Define os TextStyles específicos (simula --font-title, etc.)
  textTheme: const TextTheme(
    // Título Principal usando a fonte "Jua"
    displayLarge: TextStyle(
      fontFamily: AppFonts.text, 
      fontSize: 32, 
      color: AppColors.colorBlack,
    ),
    // Título Secundário usando a fonte "Kufam"
    headlineMedium: TextStyle(
      fontFamily: AppFonts.text,
      fontSize: 24,
      color: AppColors.colorGreen,
    ),
    // Fonte para textos normais (Herdará 'fontFamily: AppFonts.text')
    bodyLarge: TextStyle(
      fontSize: 16, 
      color: AppColors.colorBlack,
    ),
    // Fonte de Desenvolvedor (para um Text Widget específico)
    labelSmall: TextStyle(
      fontFamily: AppFonts.developer,
      fontSize: 12,
      color: AppColors.colorPaleYellow,
    )
  )
);