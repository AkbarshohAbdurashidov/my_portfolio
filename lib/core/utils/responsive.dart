import 'package:flutter/material.dart';

abstract class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double get maxWidth => 1200;

  static EdgeInsets pagePadding(BuildContext context) {
    if (isDesktop(context)) return const EdgeInsets.symmetric(horizontal: 80);
    if (isTablet(context)) return const EdgeInsets.symmetric(horizontal: 40);
    return const EdgeInsets.symmetric(horizontal: 24);
  }

  static double sectionPaddingV(BuildContext context) =>
      isMobile(context) ? 64 : 100;
}