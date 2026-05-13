import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color bg = Color(0xFF050B18);
  static const Color surface = Color(0xFF080F1E);
  static const Color card = Color(0xFF0A1628);
  static const Color cardAlt = Color(0xFF0D1B35);
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color accent = Color(0xFF60A5FA);
  static const Color cyan = Color(0xFF22D3EE);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF475569);
  static const Color border = Color(0xFF1A3252);
  static const Color borderLight = Color(0xFF1E3A5F);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color navBg = Color(0xE6050B18);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient titleGradient = LinearGradient(
    colors: [Color(0xFF93C5FD), Color(0xFF60A5FA), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF22D3EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF0A1628), Color(0xFF0D1B35)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}