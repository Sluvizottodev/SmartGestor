import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Configuração de tema da aplicação.
/// Centraliza as definições visuais do tema escuro.
class ThemeConfig {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // Define o tema como escuro.
    scaffoldBackgroundColor: AppColors.primaryBackground, // Fundo principal.
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryAccent, // Cor primária.
      secondary: AppColors.primaryAccent, // Cor secundária (botões, ícones).
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBackground, // Fundo do AppBar.
      foregroundColor: AppColors.primaryAccent, // Ícones no AppBar.
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAccent, // Cor de fundo do botão.
        foregroundColor: Colors.black, // Cor do texto do botão.
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.primaryAccent, // Ícones.
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // Texto grande.
      bodyMedium: TextStyle(color: Colors.white), // Texto médio.
      bodySmall: TextStyle(color: Colors.grey), // Texto menor.
    ),
  );
}
